package main

import (
	"bytes"
	"context"
	"flag"
	"fmt"
	"io"
	"log"
	"os"
	"os/exec"
	"os/signal"
	"time"
)

func main() {
	var refresh int
	flag.IntVar(&refresh, "refresh", 500, "refresh interval in millisecond")
	flag.Parse()

	ctx, cancel := signal.NotifyContext(context.Background(), os.Interrupt, os.Kill)
	defer cancel()

	prevBuf := &bytes.Buffer{}

	for {
		select {
		case <-ctx.Done():
			cancel()
			log.Println("exiting...")
			os.Exit(0)
		default:
		}

		buf := &bytes.Buffer{}

		if err := gitStatus(ctx, buf); err != nil {
			log.Fatal(err)
		}

		if buf.String() != prevBuf.String() {
			clearScreen()
			fmt.Printf("%s", buf.String())

			if err := gitStatus(ctx, prevBuf); err != nil {
				log.Fatal(err)
			}
		}

		time.Sleep(time.Millisecond * time.Duration(refresh))
	}
}

func gitStatus(ctx context.Context, out io.Writer) error {
	cmd := exec.CommandContext(ctx, "git", "-c", "color.status=always", "status")
	cmd.Stdout = out
	cmd.Stderr = out

	return cmd.Run()
}

func clearScreen() {
	clear := exec.Command("clear")
	clear.Stdout = os.Stdout
	clear.Run()
}
