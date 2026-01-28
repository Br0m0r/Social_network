<template>
  <div class="emoji-picker" v-if="isOpen">
    <div class="emoji-header">
      <div class="emoji-categories">
        <button 
          v-for="category in categories" 
          :key="category.name"
          @click="selectCategory(category.name)"
          :class="{ active: currentCategory === category.name }"
          class="category-btn"
        >
          {{ category.icon }}
        </button>
      </div>
      <button @click="$emit('close')" class="close-btn">✕</button>
    </div>
    
    <div class="emoji-grid">
      <button
        v-for="emoji in currentEmojis"
        :key="emoji"
        @click="selectEmoji(emoji)"
        class="emoji-btn"
      >
        {{ emoji }}
      </button>
    </div>
  </div>
</template>

<script setup>
import { ref, computed } from 'vue';

const props = defineProps({
  isOpen: {
    type: Boolean,
    default: false
  }
});

const emit = defineEmits(['select', 'close']);

const currentCategory = ref('smileys');

const categories = [
  { name: 'smileys', icon: '😊' },
  { name: 'gestures', icon: '👍' },
  { name: 'hearts', icon: '❤️' },
  { name: 'animals', icon: '🐶' },
  { name: 'food', icon: '🍕' },
  { name: 'activities', icon: '⚽' },
  { name: 'objects', icon: '💡' },
  { name: 'symbols', icon: '⭐' }
];

const emojis = {
  smileys: [
    '😀', '😃', '😄', '😁', '😆', '😅', '🤣', '😂',
    '🙂', '🙃', '😉', '😊', '😇', '🥰', '😍', '🤩',
    '😘', '😗', '😚', '😙', '🥲', '😋', '😛', '😜',
    '🤪', '😝', '🤑', '🤗', '🤭', '🤫', '🤔', '🤐',
    '🤨', '😐', '😑', '😶', '😏', '😒', '🙄', '😬',
    '🤥', '😌', '😔', '😪', '🤤', '😴', '😷', '🤒',
    '🤕', '🤢', '🤮', '🤧', '🥵', '🥶', '😶‍🌫️', '😵',
    '🤯', '🤠', '🥳', '😎', '🤓', '🧐', '😕', '😟'
  ],
  gestures: [
    '👋', '🤚', '🖐', '✋', '🖖', '👌', '🤌', '🤏',
    '✌️', '🤞', '🤟', '🤘', '🤙', '👈', '👉', '👆',
    '🖕', '👇', '☝️', '👍', '👎', '✊', '👊', '🤛',
    '🤜', '👏', '🙌', '👐', '🤲', '🤝', '🙏', '✍️',
    '💪', '🦾', '🦿', '🦵', '🦶', '👂', '🦻', '👃',
    '🧠', '🦷', '🦴', '👀', '👁', '👅', '👄', '💋'
  ],
  hearts: [
    '❤️', '🧡', '💛', '💚', '💙', '💜', '🖤', '🤍',
    '🤎', '💔', '❣️', '💕', '💞', '💓', '💗', '💖',
    '💘', '💝', '💟', '☮️', '✝️', '☪️', '🕉', '☸️',
    '✡️', '🔯', '🕎', '☯️', '☦️', '🛐', '⛎', '♈'
  ],
  animals: [
    '🐶', '🐱', '🐭', '🐹', '🐰', '🦊', '🐻', '🐼',
    '🐨', '🐯', '🦁', '🐮', '🐷', '🐸', '🐵', '🐔',
    '🐧', '🐦', '🐤', '🦆', '🦅', '🦉', '🦇', '🐺',
    '🐗', '🐴', '🦄', '🐝', '🐛', '🦋', '🐌', '🐞',
    '🐜', '🦟', '🦗', '🕷', '🦂', '🐢', '🐍', '🦎',
    '🦖', '🦕', '🐙', '🦑', '🦐', '🦞', '🦀', '🐡'
  ],
  food: [
    '🍏', '🍎', '🍐', '🍊', '🍋', '🍌', '🍉', '🍇',
    '🍓', '🫐', '🍈', '🍒', '🍑', '🥭', '🍍', '🥥',
    '🥝', '🍅', '🍆', '🥑', '🥦', '🥬', '🥒', '🌶',
    '🌽', '🥕', '🧄', '🧅', '🥔', '🍠', '🥐', '🥯',
    '🍞', '🥖', '🥨', '🧀', '🥚', '🍳', '🧈', '🥞',
    '🧇', '🥓', '🥩', '🍗', '🍖', '🌭', '🍔', '🍟',
    '🍕', '🫓', '🥪', '🥙', '🧆', '🌮', '🌯', '🫔',
    '🥗', '🥘', '🫕', '🥫', '🍝', '🍜', '🍲', '🍛'
  ],
  activities: [
    '⚽', '🏀', '🏈', '⚾', '🥎', '🎾', '🏐', '🏉',
    '🥏', '🎱', '🪀', '🏓', '🏸', '🏒', '🏑', '🥍',
    '🏏', '🪃', '🥅', '⛳', '🪁', '🏹', '🎣', '🤿',
    '🥊', '🥋', '🎽', '🛹', '🛼', '🛷', '⛸', '🥌',
    '🎿', '⛷', '🏂', '🪂', '🏋️', '🤼', '🤸', '🤺',
    '⛹️', '🤾', '🏌️', '🏇', '🧘', '🏊', '🤽', '🚣',
    '🧗', '🚵', '🚴', '🏆', '🥇', '🥈', '🥉', '🏅'
  ],
  objects: [
    '💡', '🔦', '🕯', '🪔', '🧯', '🛢', '💸', '💵',
    '💴', '💶', '💷', '🪙', '💰', '💳', '💎', '⚖️',
    '🪜', '🧰', '🪛', '🔧', '🔨', '⚒', '🛠', '⛏',
    '🪚', '🔩', '⚙️', '🪤', '🧱', '⛓', '🧲', '🔫',
    '💣', '🧨', '🪓', '🔪', '🗡', '⚔️', '🛡', '🚬',
    '⚰️', '🪦', '⚱️', '🏺', '🔮', '📿', '🧿', '💈',
    '⚗️', '🔭', '🔬', '🕳', '🩹', '🩺', '💊', '💉'
  ],
  symbols: [
    '⭐', '🌟', '✨', '⚡', '☄️', '💥', '🔥', '🌈',
    '☀️', '🌤', '⛅', '🌥', '☁️', '🌦', '🌧', '⛈',
    '🌩', '🌨', '❄️', '☃️', '⛄', '🌬', '💨', '💧',
    '💦', '☔', '☂️', '🌊', '🌫', '🔴', '🟠', '🟡',
    '🟢', '🔵', '🟣', '🟤', '⚫', '⚪', '🟥', '🟧',
    '🟨', '🟩', '🟦', '🟪', '🟫', '⬛', '⬜', '◼️',
    '◻️', '◾', '◽', '▪️', '▫️', '🔶', '🔷', '🔸',
    '🔹', '🔺', '🔻', '💠', '🔘', '🔳', '🔲', '✅'
  ]
};

const currentEmojis = computed(() => {
  return emojis[currentCategory.value] || [];
});

const selectCategory = (category) => {
  currentCategory.value = category;
};

const selectEmoji = (emoji) => {
  emit('select', emoji);
};
</script>

<style scoped>
.emoji-picker {
  position: absolute;
  bottom: 60px;
  right: 10px;
  width: 320px;
  max-height: 400px;
  background: rgba(20, 20, 40, 0.98);
  border: 1px solid rgba(0, 255, 255, 0.3);
  border-radius: 12px;
  box-shadow: 0 8px 32px rgba(0, 0, 0, 0.5);
  backdrop-filter: blur(10px);
  z-index: 1000;
  display: flex;
  flex-direction: column;
}

.emoji-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid rgba(0, 255, 255, 0.2);
}

.emoji-categories {
  display: flex;
  gap: 5px;
  flex-wrap: wrap;
}

.category-btn {
  background: transparent;
  border: none;
  font-size: 20px;
  cursor: pointer;
  padding: 5px;
  border-radius: 6px;
  transition: all 0.2s;
  opacity: 0.5;
}

.category-btn:hover {
  background: rgba(0, 255, 255, 0.1);
  opacity: 1;
}

.category-btn.active {
  background: rgba(0, 255, 255, 0.2);
  opacity: 1;
}

.close-btn {
  background: transparent;
  border: none;
  color: #fff;
  font-size: 20px;
  cursor: pointer;
  padding: 5px 10px;
  border-radius: 6px;
  transition: all 0.2s;
}

.close-btn:hover {
  background: rgba(255, 0, 100, 0.2);
}

.emoji-grid {
  display: grid;
  grid-template-columns: repeat(8, 1fr);
  gap: 2px;
  padding: 10px;
  overflow-y: auto;
  max-height: 320px;
}

.emoji-grid::-webkit-scrollbar {
  width: 6px;
}

.emoji-grid::-webkit-scrollbar-track {
  background: rgba(0, 0, 0, 0.2);
  border-radius: 3px;
}

.emoji-grid::-webkit-scrollbar-thumb {
  background: rgba(0, 255, 255, 0.3);
  border-radius: 3px;
}

.emoji-grid::-webkit-scrollbar-thumb:hover {
  background: rgba(0, 255, 255, 0.5);
}

.emoji-btn {
  background: transparent;
  border: none;
  font-size: 24px;
  cursor: pointer;
  padding: 8px;
  border-radius: 6px;
  transition: all 0.2s;
}

.emoji-btn:hover {
  background: rgba(0, 255, 255, 0.1);
  transform: scale(1.2);
}
</style>
