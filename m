Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=95.215.58.188
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794315115;
	b=LjZRJ6nhftuYzICTGBDvOGXorCShO3US6umRNGKv7DCGAv7w4P1CLegWJ1bLCuuvMjIn
	 xipZw/A2pU/XVlloi669I9tAuzVBBVD0fmlFJXpwCxCDv2+SvCYGaETzCCiA1K17VukIt
	 79U8PsbffKcgZ5mSBm08cap54XPPLE9X9Sr96nM9CQ7kQMrO5pNTgCHHeodVlKN8Jc4pK
	 lPxqWCHV/TMk8Q9dxc587rMvG3wd8MSsdk5HBK+FU7Gd/NDpaeZ54XKbAPPrfchpRzpJj
	 CQG8Y2hJ4/+Ef/naRko9fV8oruuDzGuU6FmUaed2WjnldpRi+LdW20I1H/Cs5LIFQfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794315115;
	h=DMARC-Filter:X-Envelope-To:DKIM-Signature:X-Envelope-To:Received:
	 X-Mizu-Trace-ID:X-Migadu-Flow:From:To:Cc:Subject:Date:Message-ID:
	 X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NTyrgE/NhXynhM9E29qnV24j4tJQyNRVjWGGUarqaBw=;
	b=Tme5HqTIZPScjmOBQkfjkomrhFwVKwnb8gn0PIIGZJ8aCZ1nPO3yP46DwFhKqgmVAEp7
	 E2p57UvOqOoop7cGufEcayJrYKPTejR9k4+HUbjN8oMPi68OoNbbbshEQXnvoBEIa2e5Q
	 oor8QFRyk+Pe8bnaKubHGaQ8swT5gxPnJ6BIQBkd1iOuH/5j/u+ls2S0nQu70CetI0Q50
	 EpqxnV6azNrkoApUoLX2gYKmW+CLoOI2ml9kIcQnAPAIKVWf5XBIB3e+eEXGlZzur5F0u
	 0JbwK+gQSqvuRmrMha6LB2CrlKArjsg9XxB06adHCQD/dzQUXbC8eBxKHXCrVQdfpwg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.dev;
	spf=pass smtp.mailfrom=linux.dev;
	dkim=pass header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hFpWf8yL;
	arc=none smtp.remote-ip=95.215.58.188
Received: from mta1.migadu.com (out-188.mta1.migadu.com [95.215.58.188])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 719B5606A336
	for <sched-ext@lists.linux.dev>; Tue, 10 Nov 2026 12:51:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 719B5606A336
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hFpWf8yL
X-Envelope-To: sched-ext@lists.linux.dev
DKIM-Signature: a=rsa-sha256; bh=RSQqPLCzjXzhj+yupFqjdMSCPLeZDniTWxY3yX5md4k=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794315112; v=1; x=1794919912;
 b=hFpWf8yL6oDW6NM8mtVSFMeRx7ackcDZIx2TXPgmfnP7JapwXw8H7ZJnu7sdJ3iMvZ9hGaAa
 7wkZMbsiH22HGm+8PcCw/yrkJWPxXtl1gI1mQ/FkTmK2abJ4JhAZW49r5eflssC9OL2SxaKYaIs
 1P5UA4418lmP3F0DfPoqZPLI=
X-Envelope-To: sched-ext@lists.linux.dev
Received: by smtp.migadu.com with ESMTPS id 47c838edafd7a544;
	Tue, 10 Nov 2026 12:51:52 +0000
X-Mizu-Trace-ID: 47c838edafd7a544
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
Subject: [PATCH 9/9] tools/sched_ext: scx_userland: Reject batch size 0
Date: Tue, 10 Nov 2026 20:50:01 +0800
Message-ID: <20261110125001.4167503-10-cui.tao@linux.dev>
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

-b 0 is accepted silently and leaves batch_size at zero, so
dispatch_batch() never moves a task out of the vruntime list into the
dispatched queue: tasks pile up on the vruntime list while
nr_scheduled stays positive and ops.update_idle() keeps kicking cpus;
the system-wide livelock ends when the stall watchdog kills the
scheduler.

Reject a zero batch size at option parsing.

Fixes: cc4448d0856d ("tools/sched_ext: add scx_userland scheduler")
Signed-off-by: Tao Cui <cuitao@kylinos.cn>
---
 tools/sched_ext/scx_userland.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/tools/sched_ext/scx_userland.c b/tools/sched_ext/scx_userland.c
index b16b6db5f365..cbd511685449 100644
--- a/tools/sched_ext/scx_userland.c
+++ b/tools/sched_ext/scx_userland.c
@@ -364,6 +364,11 @@ static void pre_bootstrap(int argc, char **argv)
 		}
 	}
 
+	if (!batch_size) {
+		fprintf(stderr, "Invalid batch size %s\n", optarg);
+		exit(1);
+	}
+
 	/*
 	 * It's not always safe to allocate in a user space scheduler, as an
 	 * enqueued task could hold a lock that we require in order to be able
-- 
2.53.0

base-commit: 5b740a72b55c4267ba4d8010f17dde26b26f52d3
