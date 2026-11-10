Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=91.218.175.112
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315044;
	b=BtaIFhNVBVWv2yPwxzjYm+AymUXom+BusRTLN/7YAHh8NZs/a1IANHdWnLqd1WVSQj+5
	 P0Sw0lQoXX3461Xgml0HTwTRUcCiQK5ri66cJtYMWVKxbp4EyeVbBIQYpdh4Es7HjZIj6
	 4EnLkbUn350X5IrVE0AYL6LHMQuAPtqsnGMsaayG9Os4+rOXxgv04kYEMZHc4vePYYjeh
	 hChtkZq48pGIGy8cTBeHnqLihHRcZgrEiKqlewzkvX+OrroRXoYSAYgoFZ+nj1VMWx5ak
	 vdH6sGN9SmSzb/bm31ATrANXqKfU7FNn2Up0r1huXWkOsMhFjZi7HpJWFsG7zavFwZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315044;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=JkzHOqNRmLLJHznW6kn+J0uH0vJmE5wO725J9WTQ31c=;
	b=vHDIzlcQerSel+sfhmO/PNuKNKl/pjUucvbsmwUgjZHeW/a+lhtpz3AvlFSRMTwM55st
	 c4UfatAVkNgT/tc8GIdq7TlhB5t6gMr+FKXVt8TGU3uq3JxaeAlqQ7fdsldMGvl+PVZq7
	 xx9DkF6ZrZfJSi/RxRfEMhOyFnlOTK5PEDZ0wmtipJTOnQgD/c2pQ8tgC0R9NsYeHnoWd
	 umgkHL68VgngeCWIIddIcna3ohIq4IjYiYFutnlzgLQNXJpLZWsYbnhZZpkQUPG55AlbW
	 bG+eWbU5wlu41yWAnck8nVWUylYOq0FVhrD69ZO88+wTwlbKH53tjdJrHcJdEEk8UUA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F9HvKvXX;
	arc=none smtp.remote-ip=91.218.175.112
Received: from mta0.migadu.com (out-112.mta0.migadu.com [91.218.175.112])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D65606A331
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:50:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B0D65606A331
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=F9HvKvXX
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=ogLChbToz8v2uGO8I5xWfeJmsMC5KE6fYOWugASNSTE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315040; v=1; x=1794919840;
 b=F9HvKvXXxp6hhvX5pTI7BHLeTcH74VXsTuca+5AgwgtGZfYy4LMUAuufy/75HwDsQaVCZeVf
 JFDRrk8scvbEaPHtsGNn4lapk/uxttRpJNFboRSgMpreaETXJBAf4hIF+9bu58wWdi1cEA+hrLZ
 yPqlkXxVU9FOSu+mqqFbvrMw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 1b6150941040aee2;
	Tue, 10 Nov 2026 12:50:19 +0000
X-Mizu-Trace-ID: 1b6150941040aee2
X-Migadu-Flow: FLOW_OUT
From: Tao Cui <cui.tao@linux.dev>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	liwanwu@kylinos.cn,
	devnexen@gmail.com,
	zhaomengmeng@kylinos.cn,
	emil@etsalapatis.com,
	yphbchou0911@gmail.com,
	mingo@redhat.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	cui.tao@linux.dev,
	Tao Cui <cuitao@kylinos.cn>
Subject: [PATCH 0/9] tools/sched_ext: robustness fixes from cold review
Date: Tue, 10 Nov 2026 20:49:52 +0800
Message-ID: <20261110125001.4167503-1-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Post: <mailto:sched-ext@lists.linux.dev>
List-Help: <mailto:sched-ext+help@lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
List-Owner: <mailto:sched-ext+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Tao Cui <cuitao@kylinos.cn>

Hello,

This series fixes nine robustness issues in the example schedulers
scx_pair, scx_flatcg, scx_qmap and scx_userland.

scx_flatcg resets its stats baseline on restart (stale counters print
as u64 underflow garbage) and rejects a stats interval that puts
nanosleep in an error loop (a negative or non-finite -i busy-spins at
100% CPU). scx_pair stops aborting the scheduler when the dispatching
cgroup goes away mid-dispatch, gates attach on an interrupted
initialization instead of running with a half-built cgrp_q_arr, resets
pair_id on restart, and cleans up a dead busy-check whose fall-through
clears another cgroup's busy marker. scx_qmap documents the options it
actually accepts and resets its hier stats baseline on restart.
scx_userland bounds the batch against the dispatch buffer instead of
overflowing it 13ms in, and rejects batch size 0, which livelocks the
machine until the stall watchdog fires.

Verified in qemu on tj/sched_ext for-next (5b740a72b55c), same
kernel and config with and without each patch, comparing stock and
patched binaries: a scx_flatcg restart prints six
u64-underflow garbage counters on stock and zeros with patch 1; a
non-finite -i busy-spins ~17k EINVAL lines in 3s on stock and is
rejected at parse time with patch 2; SIGINT storms abort 20/30
interrupted inits on stock with the scheduler never loading and exit
30/30 clean with patch 4; a scx_pair restart aborts 7ms in with a
stale pair_id on stock and runs clean for its full window with patch
5; an oversized scx_userland batch aborts 13ms in with "dispatch
buffer overflow" on stock and survives 25s with patch 9; and batch
size 0, which livelocks the machine until the stall watchdog fires
(spinner progress collapses to ~1%), is rejected immediately with
patch 8. Beyond the A/B pairs: the scx_pair cgid-cache churn window
is too narrow to drive (40 rounds clean on both binaries; patch 3 is
graded by inspection), the qmap synopsis diff shows exactly the three
added options (patch 6), and the hier stats baseline was verified with
a clang-23.1.5-built scx_qmap run through restart cycles (patch 7,
hier stats clean throughout).

Based on sched_ext/for-next (5b740a72b55c).

Tao Cui (9):
  tools/sched_ext: scx_flatcg: Reset the stats baseline on restart
  tools/sched_ext: scx_flatcg: Validate the stats interval
  tools/sched_ext: scx_pair: Don't abort when the dispatching cgroup
    goes away
  tools/sched_ext: scx_pair: Don't attach after an interrupted
    initialization
  tools/sched_ext: scx_pair: Reset pair_id on restart
  tools/sched_ext: scx_qmap: Add the missing options to the usage
    synopsis
  tools/sched_ext: scx_qmap: Reset the hier stats baseline on restart
  tools/sched_ext: scx_userland: Check dispatch buffer slots before
    inserting
  tools/sched_ext: scx_userland: Reject batch size 0

 tools/sched_ext/scx_flatcg.c       |  7 ++++++-
 tools/sched_ext/scx_pair.bpf.c     | 12 ++++++++++--
 tools/sched_ext/scx_pair.c         | 14 ++++++++++++--
 tools/sched_ext/scx_qmap.c         |  3 ++-
 tools/sched_ext/scx_userland.bpf.c |  8 ++++++++
 tools/sched_ext/scx_userland.c     |  5 +++++
 6 files changed, 43 insertions(+), 6 deletions(-)

-- 
2.53.0

