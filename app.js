const STORAGE_KEY = 'journali.entries.v1';

const form = document.getElementById('entryForm');
const entryText = document.getElementById('entryText');
const moodSelect = document.getElementById('moodSelect');
const tagInput = document.getElementById('tagInput');
const entryList = document.getElementById('entryList');
const searchInput = document.getElementById('searchInput');
const exportBtn = document.getElementById('exportBtn');
const importInput = document.getElementById('importInput');

let entries = loadEntries();

function loadEntries() {
  try {
    return JSON.parse(localStorage.getItem(STORAGE_KEY) || '[]');
  } catch {
    return [];
  }
}

function saveEntries() {
  localStorage.setItem(STORAGE_KEY, JSON.stringify(entries));
}

function createEntryId() {
  if (window.crypto && crypto.randomUUID) {
    return crypto.randomUUID();
  }
  return `entry-${Date.now()}-${Math.random().toString(16).slice(2)}`;
}

function formatDate(isoString) {
  return new Date(isoString).toLocaleString([], {
    dateStyle: 'medium',
    timeStyle: 'short'
  });
}

function getVisibleEntries() {
  const query = searchInput.value.trim().toLowerCase();
  return entries.filter((entry) => {
    if (!query) return true;
    return `${entry.text} ${entry.tags.join(' ')} ${entry.mood}`.toLowerCase().includes(query);
  });
}

function renderEntries() {
  const visibleEntries = getVisibleEntries();
  if (!visibleEntries.length) {
    entryList.innerHTML = '<p class="field">No entries yet. Capture your first moment.</p>';
    return;
  }

  entryList.innerHTML = visibleEntries.map((entry) => `
    <article class="entry-item">
      <div class="entry-meta">
        <strong>${entry.mood}</strong>
        <span>${formatDate(entry.createdAt)}</span>
      </div>
      <p>${entry.text}</p>
      <div class="tag-list">
        ${entry.tags.map((tag) => `<span class="tag">#${tag}</span>`).join('')}
      </div>
      <button class="delete-btn" data-id="${entry.id}">Delete</button>
    </article>
  `).join('');
}

form.addEventListener('submit', (event) => {
  event.preventDefault();
  const text = entryText.value.trim();
  if (!text) return;

  const newEntry = {
    id: createEntryId(),
    text,
    mood: moodSelect.value,
    tags: tagInput.value.split(',').map((tag) => tag.trim()).filter(Boolean),
    createdAt: new Date().toISOString()
  };

  entries = [newEntry, ...entries];
  saveEntries();
  renderEntries();
  form.reset();
  moodSelect.value = 'calm';
  entryText.focus();
});

entryList.addEventListener('click', (event) => {
  const button = event.target.closest('button[data-id]');
  if (!button) return;
  const id = button.getAttribute('data-id');
  entries = entries.filter((entry) => entry.id !== id);
  saveEntries();
  renderEntries();
});

searchInput.addEventListener('input', renderEntries);

exportBtn.addEventListener('click', () => {
  const blob = new Blob([JSON.stringify(entries, null, 2)], { type: 'application/json' });
  const url = URL.createObjectURL(blob);
  const anchor = document.createElement('a');
  anchor.href = url;
  anchor.download = 'journali-backup.json';
  anchor.click();
  URL.revokeObjectURL(url);
});

importInput.addEventListener('change', (event) => {
  const file = event.target.files?.[0];
  if (!file) return;
  const reader = new FileReader();
  reader.onload = () => {
    try {
      const imported = JSON.parse(reader.result);
      if (Array.isArray(imported)) {
        entries = imported;
        saveEntries();
        renderEntries();
      }
    } catch {
      alert('The selected file could not be imported.');
    }
  };
  reader.readAsText(file);
  event.target.value = '';
});

if ('serviceWorker' in navigator) {
  window.addEventListener('load', () => {
    navigator.serviceWorker.register('/sw.js').catch(() => {});
  });
}

renderEntries();
