package interfaces

import (
	"io"
	"os"
)

// PipeExample helps give some more examples of using io
// interfaces
func PipeExample() error {
	// the pipe reader and pipe write implement
	// io.Reader and io.Writer
	r, w := io.Pipe()

	// this needs to be run in a separate goroutine
	// as it will block waiting for the reader
	// close at the end for cleanup
	go func() {
		//for now we'll write something basic,
		// this could also be used to encode json
		// base64 encode, etc.
		w.Write([]byte("testn"))
		w.Close()
	}()

	if _, err := io.Copy(os.Stdout, r); err != nil {
		return err
	}

	return nil
}
