package main

import (
	"fmt"
	"io"
	"net/http"
	"os"
	"os/exec"
)

func main() {
	if len(os.Args) < 3 {
		fmt.Println("Usage: zpkg <add|rm|ls> [package]")
		return
	}

	switch os.Args[1] {
	case "add":
		installPackage(os.Args[2])
	case "ls":
		listPackages()
	case "rm":
		removePackage(os.Args[2])
	default:
		fmt.Println("Unknown command:", os.Args[1])
	}
}

func installPackage(pkgName string) {
	fmt.Printf("Installing %s...\n", pkgName)
	
	// Download .apk dari Alpine repo
	url := "http://dl-cdn.alpinelinux.org/alpine/v3.22/main/aarch64/" + pkgName + ".apk"
	
	// Download file
	resp, err := http.Get(url)
	if err != nil {
		fmt.Println("Error downloading:", err)
		return
	}
	defer resp.Body.Close()

	// Save .apk file
	apkFile := pkgName + ".apk"
	out, _ := os.Create(apkFile)
	io.Copy(out, resp.Body)
	out.Close()

	// Extract .apk
	extractAPK(apkFile)
	
	// Install binary
	installBinary(pkgName)
	
	fmt.Printf("✅ %s installed successfully!\n", pkgName)
}

func extractAPK(apkFile string) {
	// Extract .apk file
	cmd := exec.Command("tar", "-xf", apkFile)
	cmd.Run()
	
	// Extract data.tar.gz
	cmd = exec.Command("tar", "-xzf", "data.tar.gz")
	cmd.Run()
}

func installBinary(pkgName string) {
	// Cari binary di usr/bin/
	binaryPath := "usr/bin/" + pkgName
	if _, err := os.Stat(binaryPath); err == nil {
		// Copy binary ke current directory
		cmd := exec.Command("cp", binaryPath, ".")
		cmd.Run()
		fmt.Printf("Binary installed: ./%s\n", pkgName)
	}
	
	// Cleanup
	os.Remove(pkgName + ".apk")
	os.RemoveAll("usr")
	os.Remove("data.tar.gz")
}

func listPackages() {
	fmt.Println("Installed packages:")
	// Baca dari file database (nanti)
}

func removePackage(pkgName string) {
	// Remove binary
	os.Remove(pkgName)
	fmt.Printf("Removed %s\n", pkgName)
}
