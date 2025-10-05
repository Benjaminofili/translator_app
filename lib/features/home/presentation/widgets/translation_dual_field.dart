import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/recording_provider.dart';
import '../providers/language_provider.dart';
import '../providers/input_mode_provider.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';

/// Translation Dual Field Widget
///
/// Adapts UI based on input mode:
/// - Voice: Shows transcribed text (read-only)
/// - Text: Shows editable TextField
/// - Camera: Shows "Coming Soon" message
///
/// Path: lib/features/home/presentation/widgets/translation_dual_field.dart
class TranslationDualField extends ConsumerWidget {
  const TranslationDualField({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final recordingState = ref.watch(recordingProvider);
    final languageAsync = ref.watch(languageSelectionProvider);
    final inputMode = ref.watch(inputModeSelectionProvider);

    return languageAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (_, __) => const Center(child: Text('Error loading')),
      data: (languages) => Container(
        margin: const EdgeInsets.symmetric(horizontal: AppTheme.spacingMd),
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusLg),
          border: Border.all(
            color: Theme.of(context).colorScheme.outlineVariant,
            width: 1,
          ),
        ),
        child: Column(
          children: [
            // Source Field - Changes based on input mode
            _buildSourceField(
              context: context,
              ref: ref,
              language: languages.from,
              text: recordingState.transcribedText,
              isListening: recordingState.isRecording,
              inputMode: inputMode,
            ),

            // Divider
            if (inputMode != InputMode.camera)
              Divider(
                height: 1,
                thickness: 1,
                indent: AppTheme.spacingMd,
                endIndent: AppTheme.spacingMd,
                color: Theme.of(context).colorScheme.outlineVariant,
              ),

            // Target Field
            if (inputMode != InputMode.camera)
              _OutputField(
                language: languages.to,
                text: recordingState.translatedText,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSourceField({
    required BuildContext context,
    required WidgetRef ref,
    required String language,
    required String text,
    required bool isListening,
    required InputMode inputMode,
  }) {
    switch (inputMode) {
      case InputMode.voice:
        return _VoiceInputField(
          language: language,
          text: text,
          isListening: isListening,
        );

      case InputMode.text:
        return _TextInputField(
          language: language,
          text: text,
          onTextChanged: (newText) {
            ref.read(recordingProvider.notifier).setTranscription(newText);
            // TODO: Trigger translation
            if (newText.isNotEmpty) {
              // Simulate translation
              ref.read(recordingProvider.notifier).setTranslation(
                'Translation of: $newText',
              );
            } else {
              ref.read(recordingProvider.notifier).setTranslation('');
            }
          },
        );

      case InputMode.camera:
        return const _CameraPlaceholder();
    }
  }
}

// ═══════════════════════════════════════════════════════════════
// VOICE MODE - Read-only transcription display
// ═══════════════════════════════════════════════════════════════
class _VoiceInputField extends StatelessWidget {
  final String language;
  final String text;
  final bool isListening;

  const _VoiceInputField({
    required this.language,
    required this.text,
    required this.isListening,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.mic_rounded,
                size: 16,
                color: AppColors.sourceLanguage,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                language,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.sourceLanguage,
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (isListening) ...[
                const SizedBox(width: AppTheme.spacingSm),
                SizedBox(
                  width: 14,
                  height: 14,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppColors.translating,
                    ),
                  ),
                ),
              ],
            ],
          ),

          const SizedBox(height: AppTheme.spacingMd),

          Text(
            text.isEmpty
                ? (isListening ? 'Listening...' : 'Tap microphone to speak')
                : text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.5,
              color: text.isEmpty
                  ? theme.colorScheme.outline
                  : theme.colorScheme.onSurface,
              fontStyle: text.isEmpty ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// TEXT MODE - Editable TextField
// ═══════════════════════════════════════════════════════════════
class _TextInputField extends StatefulWidget {
  final String language;
  final String text;
  final ValueChanged<String> onTextChanged;

  const _TextInputField({
    required this.language,
    required this.text,
    required this.onTextChanged,
  });

  @override
  State<_TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<_TextInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.text);
    _focusNode = FocusNode();
  }

  @override
  void didUpdateWidget(_TextInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.text != oldWidget.text && widget.text != _controller.text) {
      _controller.text = widget.text;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.keyboard_rounded,
                size: 16,
                color: AppColors.sourceLanguage,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                widget.language,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.sourceLanguage,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const Spacer(),
              if (_controller.text.isNotEmpty)
                IconButton(
                  icon: const Icon(Icons.clear_rounded, size: 20),
                  onPressed: () {
                    _controller.clear();
                    widget.onTextChanged('');
                  },
                  tooltip: 'Clear',
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                  color: theme.colorScheme.outline,
                ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingSm),

          TextField(
            controller: _controller,
            focusNode: _focusNode,
            maxLines: null,
            minLines: 2,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.5,
            ),
            decoration: InputDecoration(
              hintText: 'Type your text here...',
              hintStyle: theme.textTheme.bodyLarge?.copyWith(
                fontSize: 16,
                color: theme.colorScheme.outline,
              ),
              border: InputBorder.none,
              contentPadding: EdgeInsets.zero,
              isDense: true,
            ),
            onChanged: widget.onTextChanged,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// CAMERA MODE - Coming Soon Placeholder
// ═══════════════════════════════════════════════════════════════
class _CameraPlaceholder extends StatelessWidget {
  const _CameraPlaceholder();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 200),
      padding: const EdgeInsets.all(AppTheme.spacingXl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.cameraActive.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.camera_alt_rounded,
              size: 40,
              color: AppColors.cameraActive,
            ),
          ),

          const SizedBox(height: AppTheme.spacingLg),

          Text(
            'Camera Translation',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: AppTheme.spacingSm),

          Text(
            'Coming Soon',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.colorScheme.outline,
            ),
          ),

          const SizedBox(height: AppTheme.spacingMd),

          Text(
            'Point your camera at text to translate it instantly',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.outline,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
// OUTPUT FIELD - Translation display
// ═══════════════════════════════════════════════════════════════
class _OutputField extends StatelessWidget {
  final String language;
  final String text;

  const _OutputField({
    required this.language,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      constraints: const BoxConstraints(minHeight: 100),
      padding: const EdgeInsets.all(AppTheme.spacingMd),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            children: [
              Icon(
                Icons.translate_rounded,
                size: 16,
                color: AppColors.targetLanguage,
              ),
              const SizedBox(width: AppTheme.spacingSm),
              Text(
                language,
                style: theme.textTheme.labelLarge?.copyWith(
                  color: AppColors.targetLanguage,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),

          const SizedBox(height: AppTheme.spacingMd),

          Text(
            text.isEmpty ? 'Translation will appear here' : text,
            style: theme.textTheme.bodyLarge?.copyWith(
              fontSize: 16,
              height: 1.5,
              color: text.isEmpty
                  ? theme.colorScheme.outline
                  : theme.colorScheme.onSurface,
              fontStyle: text.isEmpty ? FontStyle.italic : FontStyle.normal,
            ),
          ),
        ],
      ),
    );
  }
}