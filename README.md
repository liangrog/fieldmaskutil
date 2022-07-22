# Protobuf FieldMask Util in Go
Current protobuf FieldMask type [go library](https://pkg.go.dev/google.golang.org/protobuf@v1.28.0/types/known/fieldmaskpb) doesn't have `merge` implementation like its [java library](https://developers.google.com/protocol-buffers/docs/reference/java/com/google/protobuf/util/FieldMaskUtil.html#merge-com.google.protobuf.FieldMask-com.google.protobuf.Message-com.google.protobuf.Message.Builder-). It makes it hard to utilise FieldMask in the server side. Therefore I created a wrapper to existing `FieldMask` struct with added functions to make it more useful. 
