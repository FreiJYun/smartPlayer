/* SmartPlayer v0.4: cache only our trial app shell, never YouTube or Supabase. */
const CACHE='smartplayer-v04-shell-v1';
const APP='SmartPlayer_v0.4_preview.html';
self.addEventListener('install',event=>{
  event.waitUntil(caches.open(CACHE).then(cache=>cache.addAll(['./'+APP]).catch(()=>{})).then(()=>self.skipWaiting()));
});
self.addEventListener('activate',event=>{
  event.waitUntil(Promise.all([caches.keys().then(names=>Promise.all(names.filter(n=>n.startsWith('smartplayer-v04-')&&n!==CACHE).map(n=>caches.delete(n)))),self.clients.claim()]));
});
self.addEventListener('fetch',event=>{
  const req=event.request;
  const url=new URL(req.url);
  if(req.method!=='GET'||url.origin!==self.location.origin||!url.pathname.endsWith('/'+APP))return;
  event.respondWith(fetch(req).then(response=>{
    if(response.ok){const copy=response.clone();caches.open(CACHE).then(cache=>cache.put(req,copy)).catch(()=>{});}
    return response;
  }).catch(()=>caches.match(req)));
});
