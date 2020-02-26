enum Emoji { happy, sad, angry }

String emojiSelected(Emoji emoji) {
  switch (emoji) {
    case Emoji.happy:
      return '😄';
    case Emoji.angry:
      return '😡';
    case Emoji.sad:
      return '😭';

    default:
      return '';
  }
}
