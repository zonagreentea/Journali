import React, { useState, useEffect } from 'react'

function loadEntries() {
  try {
    const raw = localStorage.getItem('journali.entries')
    return raw ? JSON.parse(raw) : []
  } catch (e) {
    return []
  }
}

function saveEntries(entries) {
  localStorage.setItem('journali.entries', JSON.stringify(entries))
}

export default function App() {
  const [entries, setEntries] = useState(loadEntries)
  const [text, setText] = useState('')

  useEffect(() => {
    saveEntries(entries)
  }, [entries])

  function addEntry() {
    if (!text.trim()) return
    const e = { id: Date.now(), timestamp: new Date().toISOString(), text }
    setEntries([e, ...entries])
    setText('')
  }

  return (
    <div className="app">
      <header>
        <h1>Journali (Web)</h1>
      </header>
      <main>
        <section className="composer">
          <textarea value={text} onChange={e => setText(e.target.value)} placeholder="Write something to beat boredom..."></textarea>
          <button onClick={addEntry}>Save</button>
        </section>
        <section className="entries">
          {entries.map(e => (
            <article key={e.id} className="entry">
              <time>{new Date(e.timestamp).toLocaleString()}</time>
              <p>{e.text}</p>
            </article>
          ))}
        </section>
      </main>
    </div>
  )
}
