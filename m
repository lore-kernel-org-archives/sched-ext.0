Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.157
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315097;
	b=A4iMrjBtEdj2P2GAtj0GtUeDeAgHXgt+DXp54mzzeSDzlycatZ0SaB43Fz8dKNpi9g87
	 GMqjrSWeilU5QUJDH93HU7WNmYfJNVG7hhnYNZyBhaj4Xe9ynDQ+nRZVCZe1rpzguGDuA
	 HFCJs8uY6L5MworiPPcfvyAcowNFgMw+RifpI0Ba8AXxnmOWiP/Hb9pOzpj7NFPX6yu+q
	 1HZPmQJF6o+5MEQi6+kbnCrZXUJ9HfEnDC1Cj4oMuQdTVQ+wFhHUoeMmenFMe8Nb5AOhI
	 QvRsaQhfiiKpMZ7IWL9kjTB1JHMdcSKkom1+O62E2A+mxAl5jFDiCpoi2xFEh0/LPqA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315097;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=RFv7UBnzr82TPaBJp6124pYT0jBn52Qd5UGAxk9lS1k=;
	b=2rGA/qqNDaR8aHB1JG8qNWS85BH1SnhjnrExwBFJs/A7TzQtxtxDEviTSiL2WrDMhiNB
	 UT0JqDzqdWAjBouVeBvvYkjpU/Tp8gRJv4ERyhnylhqy1bGmPd8Y3NaIspwj1cqwFI5pS
	 w2Z1d8AQqKda9DzgKH2NGGrycBEcO8HAMNoU6COOsQbwojzYPR+HCti+lN0Hi+rVpwJX5
	 3U1BadAfa1nonIrgi88rsctbymK6zBTkOlK7SPSbbmDjXH4aW+1W9rwfH31dUu+gQ+Rkp
	 z18IaVqhEOOWHQEW1GFBE5ut7Z+0GGOHzoJx7mNMOOPtizfbEF2Y/MBNea/Rx9z8G7w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eI0hhfBk;
	arc=none smtp.remote-ip=95.215.58.157
Received: from mta1.migadu.com (out-157.mta1.migadu.com [95.215.58.157])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFD5660A380D
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EFD5660A380D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=eI0hhfBk
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=yfFCdwk/e0ynSBLLJzEBbB0h06SCnoIpbB2KBYA+o3A=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315095; v=1; x=1794919895;
 b=eI0hhfBko2JouH7RYZ9tlExYSJ9hzzgSX0XH+CTssWTj785ADQV5O/OHndy1yC/5nsNXNkPL
 dsVOHs8oR50SURwnkNmQRrXY9KV3eD8vgb7FtUlZ4j97voYIOXeI7eivz1B17jXTvRU8Cd016qS
 CNTcfsiCeGRt1Iqyg9E7H5qw=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id de0f297dc80b2cf4;
	Tue, 10 Nov 2026 12:51:34 +0000
X-Mizu-Trace-ID: de0f297dc80b2cf4
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
Subject: [PATCH 7/9] tools/sched_ext: scx_qmap: Reset the hier stats baseline on restart
Date: Tue, 10 Nov 2026 20:49:59 +0800
Message-ID: <20261110125001.4167503-8-cui.tao@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110125001.4167503-1-cui.tao@linux.dev>
References: <20261110125001.4167503-1-cui.tao@linux.dev>
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

hprev holds the previous per-participant counter snapshots for the
hier stats deltas and is initialized before the restart: label, so a
hotplug-triggered fail-safe reload leaves it holding snapshots from
the previous generation while the scheduler's own counters start from
zero; the first stats interval prints u64-underflow garbage.

Reset it together with optind on reload.

Fixes: e9151ed5c944 ("tools/sched_ext: scx_qmap - Expand hierarchical sub-scheduling")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_qmap.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/sched_ext/scx_qmap.c b/tools/sched_ext/scx_qmap.c
index f44802247069..414afb817e0a 100644
--- a/tools/sched_ext/scx_qmap.c
+++ b/tools/sched_ext/scx_qmap.c
@@ -292,6 +292,7 @@ int main(int argc, char **argv)
 	}
 restart:
 	optind = 1;
+	memset(&hprev, 0, sizeof(hprev));
 	skel = SCX_OPS_CID_OPEN(qmap_ops, scx_qmap);
 
 	skel->rodata->slice_ns = skel->rodata->__SCX_SLICE_DFL;
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
