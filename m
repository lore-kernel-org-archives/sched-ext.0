Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75E3238C404
	for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 04:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773289210; cv=none; b=fEj00xZbADtscx2axeRbo8NaOoXVxH//BnN15iGfgdexQUlwgWAABXVocCUnP+tbslIYa9MmjlVUf9CDUSl6gPOL+FSB8Ok1hAVM4XpxJeIan/iBRtiT9xGGHIMOA1S0R5A44FdhSlR90wllo3aSm5W2wpMnfmSSeAMQHCTT5VE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773289210; c=relaxed/simple;
	bh=6Glqu3HLAueQVTkn7dgW90MifJ089buCA7dashYukyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HtMuBJa5BEakgpdLUEeI0HosdLRF1rcCeWThANuuyjGEd2bGj2fUZj4v1Y7CFYsUsdCC4BHsq+ytXW4FIqmZnIvB8wAxH7riOTtt+MW8i3aXR/dYZA43sJ/07QWlRXM+lDdD0aWseXZRcSVXiDFQ46qeXlP1LAofJOlCQLjhPys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JWln0gzd; arc=none smtp.client-ip=209.85.215.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JWln0gzd"
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c73a12af63cso334216a12.0
        for <sched-ext@lists.linux.dev>; Wed, 11 Mar 2026 21:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773289208; x=1773894008; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xm4JOQ4w3uTDNBYmXkmtBW3J1FJeTNuyT/97jTQiZ0w=;
        b=JWln0gzdw3W9W7HS1IPkzvdmKbYZjuudliGomCKMuzQsQbzUQRcWDwNHXu4RIf+8cM
         IW3kTngiiY285eNKkrApt2YXXEAxfeAR1tMbQVltEW0xJJmTXHNneOzRlkzYYWtUBUqX
         VWCY/rnGt8DP8JUul6t6f5lbZNrInezcsZ3z5wHC0bChq7RMdvBm/FOHY1uYwRgtuxfH
         3RBg/bf/Q31T3dwwCyfc17kDvO2SFl22dLeHdvDZEtasn2bDcLMs3khsaK2XzZMwBxO2
         bELXPXoNg+QGfbNSC2z+7jxPGNsSwBXsgzDj34Ojy9uglXfL4AQABFa5a4LDtQ/vWLLK
         vdEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773289208; x=1773894008;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xm4JOQ4w3uTDNBYmXkmtBW3J1FJeTNuyT/97jTQiZ0w=;
        b=KgoDRrjJWVA3Vj/3wJZN5HGMm0HnGvEA2QHjYGHD5NH9YL9MHqibA5RDzcaL8KBnUN
         huEgHPQB2fHOy5aZzXAccow6Nc+GVbRiXFE2t6hARE3wxYJS/IZDdIzDpEvV65yX33eq
         h16FBBTVk/EAM3eJocfWdfohlZxfpQ1ujF2/pjhgBlJiZ2iWrwyzvftCe03suUJl+Sp/
         yN1IyP+UH8YvQVuxR+p6zD2qW82YOkTJWOHkIMbDryKB8ohkptPbFnxEBGC9lEig61Vy
         7BsdUWREFMy32KeWKVMtKMoa0qIypTv9KLFTFgAY+9vbQ/fgnbtMofWxjtnBLYbBearx
         DhRw==
X-Gm-Message-State: AOJu0Yy+A/K7u7WRaJGwe775WKCpGZZoKzF9sfP/19aZOKHC6zg3Y172
	xyT7plGLnTD+qT07Kb6JUb0m1hCY2JexcOTO1obKncvSiHK96viuipvHhzxFLWmg
X-Gm-Gg: ATEYQzwOtEE7KpNwKX4yF26RCuSA56tS9yLkMoCvsVXTwOiAHFAnxBvsnsk9SYIdNlL
	TXaiwQWclBYLknszmalS/2eUiZEzVazD+8nJ+bwbZ4zNw7UUPfboRInYZQrC2YombiSzLg2ehsg
	MtiE3iKE+i0b21NQ04UCaJXBNT5FPnj2/4wmQbOXg0oc7lxXYRQd7D3sEkG71qw4Ywi37frARPS
	kwTZPsx4YDsyjAYR4vNRfQPst64ajJkWDCS5tImxfqGGntY1zo0IHN4ncmHWOubtxq2U9CZ7oBg
	w+oA+3ei4Y8xca6UM3gM2In1joHz4InMI9+KEgzp63HB+n72+cMk8nwvyZRfxya9SIX0PxDubnV
	7cJgwn7aVIm4QyXtKnsrM87kT2XBWxxVmW/ig+LnpvODUhzb3edUJSlrrRD1BuKDete8eAj4jne
	4m9JAIEJVpyX7j6jC0M3gK4YpeqXyT2m58n63NpM3sXZBV2gpEQR6n
X-Received: by 2002:a17:902:ce0b:b0:2ae:c0a4:5945 with SMTP id d9443c01a7336-2aec0a45e5fmr5969895ad.29.1773289208451;
        Wed, 11 Mar 2026 21:20:08 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:c33f:dccb:5456:7509])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aebf1dd261sm6265375ad.90.2026.03.11.21.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2026 21:20:08 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH 0/2] sched_ext: Update demo schedulers and selftests for deprecated APIs
Date: Thu, 12 Mar 2026 12:19:59 +0800
Message-ID: <20260312042001.955675-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Two sets of sched_ext APIs have been deprecated:

- Direct writes to p->scx.dsq_vtime in favor of 
  scx_bpf_task_set_dsq_vtime()
- ops.cpu_acquire/release() in favor of handling CPU preemption via the
  sched_switch tracepoint

This series updates the demo schedulers (scx_simple, scx_flatcg,
scx_qmap) and selftests (select_cpu_vtime, maximal) to use the new
APIs, keeping them in sync with current best practices.

Patch 1 uses bpf_ksym_exists() to fall back to direct assignment on
older kernels that don't have scx_bpf_task_set_dsq_vtime(), preserving
backwards compatibility.

Patch 2 removes the cpu_acquire/release stubs and the
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
scx_qmap, unconditionally relying on the sched_switch TP.

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Update demo schedulers and selftests to use
    scx_bpf_task_set_dsq_vtime()
  sched_ext: Update demo schedulers and selftests to drop
    ops.cpu_acquire/release()

 tools/sched_ext/scx_flatcg.bpf.c              | 21 ++++++++++++++-----
 tools/sched_ext/scx_qmap.bpf.c                | 15 ++-----------
 tools/sched_ext/scx_simple.bpf.c              | 12 +++++++++--
 .../testing/selftests/sched_ext/maximal.bpf.c | 15 ++++++-------
 .../sched_ext/select_cpu_vtime.bpf.c          | 13 ++++++++++--
 5 files changed, 45 insertions(+), 31 deletions(-)

-- 
2.48.1

