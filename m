Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5937D35D5EE
	for <sched-ext@lists.linux.dev>; Fri, 23 Jan 2026 03:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769138788; cv=none; b=fLrGU+/wxqy3vHFMRmafDT+byuxImXBD86DVHNr8U6BFWf5PsC3gu+Ucvy4R89UTKdYTeRoMyACaCA6qIAcxOMz9C2KlNrspurdnNKCoWxUeg6fV6/QFarEJofpF1Hiq8VXpoRMZkmEnkzEtDjAFcrXBjaAw7a/p32Y6vspWlxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769138788; c=relaxed/simple;
	bh=8oc9eOK5pZ94WrR0ahoP1HS9QX7iaHI6fFMw4KWkv1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXKHq36QB8CwwEAdSMJ9hJFc3FOSvUM6CW/Bxx09DOxL4FxtUfn8CccR3Ed8XR1Cyet0tCFokUmF0H7IJe4uwMGZUmWY+Da8h5yGrzJP20+yN0oSkvPts4c9WM5AmEzgsMztDTlJUdnAWfRuch6NUnhmbkXYzcH96u0Ncix5p+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b=aiD4khL+; arc=none smtp.client-ip=209.85.219.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=etsalapatis.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=etsalapatis-com.20230601.gappssmtp.com header.i=@etsalapatis-com.20230601.gappssmtp.com header.b="aiD4khL+"
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-894770e34afso33043336d6.0
        for <sched-ext@lists.linux.dev>; Thu, 22 Jan 2026 19:26:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20230601.gappssmtp.com; s=20230601; t=1769138781; x=1769743581; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EUeIhIp+ttKyRV5bpWWAQuPJn4faHQImgsrpl/40tH4=;
        b=aiD4khL+BAETIZQXRPV5nVUecgtQkUFj+KslfSiiJlZLLECrHu/FMLyhoU6SWg7ZM4
         ew4E0nqle4BVMhPqV5+b/mQ3mH/Vb6tv6JkvJ8CHp9mXVkByKHvRwuXkXbFFVdudUHr5
         iTE2MVxxMFRIYfbWE21NgQks+wzDveQIp8bKFAst8L5oHArV9efDUfxpzpjAgTBDRsFY
         hhfcGMgvIxm0jgslhjr2C7u93C68fNXhtMTttujpM/4WoudS2WnVs2DNwa3FMNWt8916
         Ww1epvNK4M/CfBaMKrJA2QGtHLgGFyGVZk0ERspr0vrw63M1UzqC1CjtuzkxdKi4zYo6
         jQhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769138781; x=1769743581;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EUeIhIp+ttKyRV5bpWWAQuPJn4faHQImgsrpl/40tH4=;
        b=Z6x6ZmL/5Uc/ekem+xsEKtaXMsvHLoCEWSgVRcddPLiC6hbAES1TYV3fSVCRqry9PD
         cObaxHCRq7cSgHScG2bNCjG8pOTqva/UIa9LYr7m4ts8KQRcfGhfzugE3B3uDZ67z8K0
         ppk45QRVPlSm5UkD0sR6VU+3WXL3ZBBudIObNCIagWyR1x3N0aqla/Vzu98kcbzcOhE4
         27uniRSiU72Z8yI3ra9Yyi9F8p4Kz0KiTdVd8uNXC0JRyvWYL8spUTEOI9gq9kDfYwVJ
         96NLcbxkfXJmcIaYkf4QEv722w4cQ32dU7CL99ltfj5k6jel7AVPi/lurD4EuT/HssJr
         lI2g==
X-Gm-Message-State: AOJu0Yy5k48yH8ioBvSXdgVcdQyn8hqEWvyPpRRp2zZ9dVmpn3njvDPq
	qF004/Lb6yWcYt4HTFh1symsgL7B9WgHlSQsR6MX3EM/LzLPDSzI9uhffPzwomlYwa6DFY9Zt3w
	CpD0R
X-Gm-Gg: AZuq6aLgnDG6ngk/9lSEjHZitRjjE0vnaHNEGGeKoxtE0c2MTM0WvrMJbSBftq+HcI7
	guQaOJjKaUtysri0936Y3b64TxEiuttxZbM6dXflS0QTFheS9uFgyWG/2znSsXlXzXgyCyQWIUs
	JrAaHQZu9p0eMvMOsT3Rzym/cbav0VtBLdmaMnNK7854exrik3S5pboedqowxNN4z2ipytyEUhS
	+il5TJDuUCvDiJXONt//LW1EdP0rMTvBp0vhWo0Nbh/DfUibUmA0zaIpojjmricY3hejppJZGjX
	z0rXOjfWI/yr3JlhxFPEV7qxn/c9JGDFP2wwFRI+gq/DwcgVlX6cDspLjCty81FgZQmFtfMHbrX
	iQh3Msb8QkBIc3gHLkmmVtK8qUZXyunTxDxvAY8tKaoBF/toZkFNqiiGOvqs0u6evbLlA3Ejbvf
	sIErMxAu4WNw==
X-Received: by 2002:a05:6214:ca2:b0:889:b6f1:1f30 with SMTP id 6a1803df08f44-894901ce3e7mr27365186d6.18.1769138780588;
        Thu, 22 Jan 2026 19:26:20 -0800 (PST)
Received: from boreas.. ([140.174.219.137])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8c6e3855617sm80725485a.43.2026.01.22.19.26.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 19:26:20 -0800 (PST)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: sched-ext@lists.linux.dev
Cc: changwoo@igalia.com,
	arighi@nvidia.com,
	tj@kernel.org,
	void@manifault.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH v3 0/3] tools/sched_ext: Add example C schedulers
Date: Thu, 22 Jan 2026 22:26:02 -0500
Message-ID: <20260123032605.49140-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add to the tree several C sched-ext schedulers developed and maintained 
out-of-tree by the sched-ext project over the years. These schedulers 
demonstrate sched-ext's feature set and provide a starting point for 
scheduler development. Place the schedulers together with the existing 
examples in tools/sched_ext.

v2->v3 (https://lore.kernel.org/sched-ext/20260113164818.14305-1-emil@etsalapatis.com/)

- Fix inverted condition in scx_sdt for zeroing out freed memory (AI)

v1->v2 (https://lore.kernel.org/sched-ext/20260112214131.50236-1-emil@etsalapatis.com/

- Remove scx_nest scheduler from patchset (Changwoo, Andrea)

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>

Emil Tsalapatis (3):
  tools/sched_ext: add scx_userland scheduler
  tools/sched_ext: add scx_pair scheduler
  tools/sched_ext: add arena based scheduler

 tools/sched_ext/Makefile           |   2 +-
 tools/sched_ext/scx_pair.bpf.c     | 610 +++++++++++++++++++++++++
 tools/sched_ext/scx_pair.c         | 180 ++++++++
 tools/sched_ext/scx_pair.h         |   9 +
 tools/sched_ext/scx_sdt.bpf.c      | 710 +++++++++++++++++++++++++++++
 tools/sched_ext/scx_sdt.c          | 101 ++++
 tools/sched_ext/scx_sdt.h          | 113 +++++
 tools/sched_ext/scx_userland.bpf.c | 344 ++++++++++++++
 tools/sched_ext/scx_userland.c     | 437 ++++++++++++++++++
 tools/sched_ext/scx_userland.h     |  17 +
 10 files changed, 2522 insertions(+), 1 deletion(-)
 create mode 100644 tools/sched_ext/scx_pair.bpf.c
 create mode 100644 tools/sched_ext/scx_pair.c
 create mode 100644 tools/sched_ext/scx_pair.h
 create mode 100644 tools/sched_ext/scx_sdt.bpf.c
 create mode 100644 tools/sched_ext/scx_sdt.c
 create mode 100644 tools/sched_ext/scx_sdt.h
 create mode 100644 tools/sched_ext/scx_userland.bpf.c
 create mode 100644 tools/sched_ext/scx_userland.c
 create mode 100644 tools/sched_ext/scx_userland.h

-- 
2.49.0

