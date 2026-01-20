import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

enum FileType { image, video, document, any }

class FileFieldInput extends StatefulWidget {
  final String label;
  final IconData? icon;
  final FileType fileType;
  final bool multiple;
  final List<String>? initialFileUrls;
  final Function(List<File>)? onFilesSelected;

  const FileFieldInput({
    super.key,
    required this.label,
    this.icon,
    this.fileType = FileType.image,
    this.multiple = false,
    this.initialFileUrls,
    this.onFilesSelected,
  });

  @override
  State<FileFieldInput> createState() => _FileFieldInputState();
}

class _FileFieldInputState extends State<FileFieldInput> {
  List<File> _selectedFiles = [];
  late List<String>? _initialFileUrls;

  @override
  void initState() {
    super.initState();
    _initialFileUrls = widget.initialFileUrls;
  }

  Future<void> _showSourceDialog() async {
    if (widget.fileType != FileType.image &&
        widget.fileType != FileType.video) {
      _pickFile(ImageSource.gallery);
      return;
    }

    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt),
                title: const Text('Cámara'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile(ImageSource.camera);
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library),
                title: const Text('Archivos'),
                onTap: () {
                  Navigator.pop(context);
                  _pickFile(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _pickFile(ImageSource source) async {
    final ImagePicker picker = ImagePicker();

    try {
      if (widget.multiple && source == ImageSource.gallery) {
        final List<XFile> images = await picker.pickMultipleMedia();
        if (images.isNotEmpty) {
          setState(() {
            _selectedFiles.addAll(images.map((xFile) => File(xFile.path)));
            _initialFileUrls = null;
          });
          widget.onFilesSelected?.call(_selectedFiles);
        }
      } else {
        XFile? file;

        switch (widget.fileType) {
          case FileType.image:
            file = await picker.pickImage(source: source);
            break;
          case FileType.video:
            file = await picker.pickVideo(source: source);
            break;
          default:
            file = await picker.pickImage(source: source);
        }

        if (file != null) {
          setState(() {
            if (widget.multiple) {
              _selectedFiles.add(File(file!.path));
            } else {
              _selectedFiles = [File(file!.path)];
            }
            _initialFileUrls = null;
          });
          widget.onFilesSelected?.call(_selectedFiles);
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error al seleccionar archivo: $e')),
      );
    }
  }

  void _removeFile(int index) {
    setState(() {
      _selectedFiles.removeAt(index);
    });
    widget.onFilesSelected?.call(_selectedFiles);
  }

  Widget _buildFilePreview(File file, int index) {
    final isImage =
        widget.fileType == FileType.image ||
        file.path.toLowerCase().endsWith('.jpg') ||
        file.path.toLowerCase().endsWith('.jpeg') ||
        file.path.toLowerCase().endsWith('.png');

    return Stack(
      children: [
        Container(
          width: 100,
          height: 100,
          margin: const EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(8.0),
            border: Border.all(color: Colors.red[300]!),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: isImage
                ? Image.file(file, fit: BoxFit.cover)
                : Center(
                    child: Icon(
                      _getFileIcon(),
                      size: 40,
                      color: Colors.red[300],
                    ),
                  ),
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: GestureDetector(
            onTap: () => _removeFile(index),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.red,
                shape: BoxShape.circle,
              ),
              child: const Icon(Icons.close, color: Colors.white, size: 20),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildInitialFilePreview(String url, int index) {
    final isImage =
        url.toLowerCase().contains('.jpg') ||
        url.toLowerCase().contains('.jpeg') ||
        url.toLowerCase().contains('.png') ||
        widget.fileType == FileType.image;

    return Container(
      width: 100,
      height: 100,
      margin: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.red[50],
        borderRadius: BorderRadius.circular(8.0),
        border: Border.all(color: Colors.red[300]!),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(8.0),
        child: isImage
            ? Image.network(url, fit: BoxFit.cover)
            : Center(
                child: Icon(_getFileIcon(), size: 40, color: Colors.red[300]),
              ),
      ),
    );
  }

  IconData _getFileIcon() {
    switch (widget.fileType) {
      case FileType.image:
        return Icons.image;
      case FileType.video:
        return Icons.video_file;
      case FileType.document:
        return Icons.description;
      case FileType.any:
        return Icons.attach_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final hasFiles = _selectedFiles.isNotEmpty;
    final hasInitialFiles =
        _initialFileUrls != null && _initialFileUrls!.isNotEmpty;

    return Padding(
      padding: const EdgeInsetsDirectional.symmetric(
        vertical: 8.0,
        horizontal: 10.0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              if (widget.icon != null) ...[
                Icon(widget.icon),
                const SizedBox(width: 15),
              ],

              Text(
                widget.label,
                style: Theme.of(context).textTheme.labelLarge?.copyWith(
                  color: isDark
                      ? const Color(0xFFE5E5E5)
                      : const Color(0xFF6B6B6B),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8.0),
          if (hasFiles || hasInitialFiles)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8.0),
                border: Border.all(),
              ),
              child: Wrap(
                children: [
                  ...List.generate(
                    _selectedFiles.length,
                    (index) => _buildFilePreview(_selectedFiles[index], index),
                  ),
                  if (!hasFiles && hasInitialFiles)
                    ...List.generate(
                      _initialFileUrls!.length,
                      (index) => _buildInitialFilePreview(
                        _initialFileUrls![index],
                        index,
                      ),
                    ),
                  if (widget.multiple || !hasFiles)
                    GestureDetector(
                      onTap: _showSourceDialog,
                      child: Container(
                        width: 100,
                        height: 100,
                        margin: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            width: 1,
                            style: BorderStyle.solid,
                          ),
                        ),
                        child: const Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.add, size: 40),
                            SizedBox(height: 4),
                            Text('Agregar', style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
            )
          else
            GestureDetector(
              onTap: _showSourceDialog,
              child: Container(
                width: double.infinity,
                height: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                  border: Border.all(),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(_getFileIcon(), size: 50),
                    const SizedBox(height: 8.0),
                    Text(
                      widget.multiple
                          ? 'Selecciona archivos'
                          : 'Selecciona un archivo',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
