const CORS_HEADERS = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Methods': 'GET, PUT, OPTIONS',
  'Access-Control-Allow-Headers': 'Content-Type, X-Sync-Pin',
};

function jsonResponse(body, status = 200) {
  return new Response(JSON.stringify(body), {
    status,
    headers: { 'Content-Type': 'application/json', ...CORS_HEADERS },
  });
}

function isValidPin(pin) {
  return typeof pin === 'string' && /^[a-zA-Z0-9]{4,32}$/.test(pin);
}

async function handleSync(request, env) {
  if (request.method === 'OPTIONS') {
    return new Response(null, { headers: CORS_HEADERS });
  }

  const pin = request.headers.get('X-Sync-Pin');
  if (!isValidPin(pin)) {
    return jsonResponse({ error: 'invalid_pin' }, 400);
  }

  const key = `user:${pin}`;

  if (request.method === 'GET') {
    const raw = await env.SYNC_KV.get(key);
    if (!raw) return jsonResponse({ data: null, updatedAt: null });
    const record = JSON.parse(raw);
    return jsonResponse({ data: record.data, updatedAt: record.updatedAt });
  }

  if (request.method === 'PUT') {
    let body;
    try {
      body = await request.json();
    } catch {
      return jsonResponse({ error: 'invalid_json' }, 400);
    }

    const { data, updatedAt } = body;
    if (!data || typeof updatedAt !== 'string') {
      return jsonResponse({ error: 'missing_fields' }, 400);
    }

    const existingRaw = await env.SYNC_KV.get(key);
    if (existingRaw) {
      const existing = JSON.parse(existingRaw);
      if (existing.updatedAt && existing.updatedAt > updatedAt) {
        return jsonResponse(
          { error: 'conflict', data: existing.data, updatedAt: existing.updatedAt },
          409,
        );
      }
    }

    await env.SYNC_KV.put(key, JSON.stringify({ data, updatedAt }));
    return jsonResponse({ ok: true, updatedAt });
  }

  return jsonResponse({ error: 'method_not_allowed' }, 405);
}

export default {
  async fetch(request, env) {
    const url = new URL(request.url);
    if (url.pathname === '/api/sync') {
      return handleSync(request, env);
    }
    return env.ASSETS.fetch(request);
  },
};
