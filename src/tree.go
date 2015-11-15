package main

import (
	"bytes"
	"flag"
	"fmt"
	"io/ioutil"
	"os"
	"path/filepath"
	"strconv"
	"strings"
)

// I usually use the `tree` command  in ubuntu , but osx lacks this
// So I produce this small wheel .
// quorzz@gmail.com
// 2015年11月15日09:08:44

type DirTree struct {
	path   string
	deep   int64
	output *bytes.Buffer
}

func InitDirTree() *DirTree {
	return &DirTree{
		path:   ".",
		deep:   0,
		output: bytes.NewBuffer([]byte{}),
	}
}

func main() {
	flag.Parse()
	args := flag.Args()

	dt := InitDirTree()
	if flag.Arg(0) != "" {
		dt.path = args[0]
	}
	if flag.Arg(1) != "" {
		dt.deep, _ = strconv.ParseInt(strings.TrimLeft(args[1], "-"), 10, 64)
	}

	dt.Tree(dt.path, 0)

	fmt.Println(string(bytes.TrimRight(dt.output.Bytes(), "\n")))
}

func (dt *DirTree) Tree(path string, n int) {
	files, err := ioutil.ReadDir(path)
	if err != nil {
		fmt.Println(err.Error())
		os.Exit(1)
	}

	for _, file := range files {
		if dt.deep != 0 && int64(n) >= dt.deep {
			return
		}
		newPath := filepath.Join(path, file.Name())
		fs, e := os.Stat(newPath)
		if e != nil {
			fmt.Println(e.Error())
			os.Exit(2)
		}
		if fs.IsDir() {
			dt.dirOutput(file.Name(), n)
			dt.Tree(newPath, n+1)
		} else {
			dt.fileOutput(file.Name(), n)
		}
	}
}

func (dt DirTree) fileOutput(f string, n int) {
	dt.output.WriteString(fmt.Sprintf("%s[%dm", "\033", 33))
	dt.commonOutput(f, n)
}

func (dt DirTree) dirOutput(f string, n int) {
	dt.output.WriteString(fmt.Sprintf("%s[%dm", "\033", 32))
	dt.commonOutput(f, n)
}

func (dt *DirTree) commonOutput(f string, n int) {
	dt.output.Write(bytes.Repeat([]byte("| "), n))
	dt.output.WriteString("|___ ")
	dt.output.WriteString(f)
	dt.output.WriteString("\n")
}
