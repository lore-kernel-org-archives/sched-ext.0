Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFB625B0B8
	for <sched-ext@lists.linux.dev>; Tue, 14 Jul 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783997235; cv=none; b=Nkwk4hu9+/DxMXhwa1Bc43+KOBR7n7YDZi3XoKML/+9IGiTtYbsqc2BgAhx/4CrjS/H5gHJUpaXQkIpb+Ue+cUxMB0pPDwxmE5iAlVJdwPHQ7RaD5JfFcODcLsatvCwBxg6la07J8+HssmYJ31Mz+xrwSQqK+B/NJGRvhG0Uqz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783997235; c=relaxed/simple;
	bh=Jmbq4Z26iQHkmKxrnQWds2dMifspHX44AzT9QT2tZJ4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=G9KV/HKUTButfK3BtyweDKEXmzrwWgKfmAitSO6n9sZ5dXMbDYy74eU07ugBdjolQwQVHS9uVVpvNJXin0XoEq5UkvI/q96hsxD3SgSTeTuslPTwdDDZVtoMvxhakA/SezBTzpqDDie6yIMifXijQh6QTXbp6U/1DFYpoNvKQ6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AsiVQpAn; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AsiVQpAn"
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-c966b9ee9cbso2122421a12.1
        for <sched-ext@lists.linux.dev>; Mon, 13 Jul 2026 19:47:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783997233; x=1784602033; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=C/jMBU38+ad+mYHMb9OoGQI14GFwZsPgUUyAfPzMVGI=;
        b=AsiVQpAn0GyUMzyz00o+nn8ifsIR++AoyWZ/bZXPZhXcZ0XJzChlGYTyNI03Pkj1fD
         nvtUp5isbDV5BWVheAVerjfNahrkVc3SnadS5NR6NkE1Xbkv80x1CGftxfR9nlJf1Bbv
         cW434FPQUWOAUUlEW1fjZhiR6nHybPxOmePt8OGhmRW58QUmTcUHo/KRd9S9avtGIV3e
         SBOHj7WVSQ1fhY921lDX/ZCyui1eSsPHK3Lw6xM22UmuWEuHlbGC+6BE/IB4W/3HozCA
         t6oHjNMrIACOfqgKoMRjhcfMVwudWTOS4r7LiSQiFcAD8xJAziMi3P1wc/UZS2HIlXIi
         PjPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783997233; x=1784602033;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=C/jMBU38+ad+mYHMb9OoGQI14GFwZsPgUUyAfPzMVGI=;
        b=DaOIVqe26wbh/TpdAJRt7zYRVkaJuMYn8n8iFv5F4PU6knwer6P/+q8v2afhUqdXHF
         xDOAYF3Rgi2P6FdfN1+2XaxSX0E6rycmpu5tYXIEYj5gLdi2HbjnC+KygOLDPGoKjjMB
         1AxG1MVikV2XiAiHL4grZb4h4Zj5ytYJ0FD257hHwzwBO+nDrAFaVgddhbWK3LJhs09h
         n8t9E1f9l2rijcSxX8mEHlBDq3tsWj5gQEsjLiNpshQNOmZVEqE+EYIec9zDZLKM7egY
         p8mAGt+UtEAVWHlCyYiKv85N7GTCPSkXLT9GUB8glRrMSAQ44wZqWlODqeCEQw0j8HGF
         Llbw==
X-Forwarded-Encrypted: i=1; AHgh+RrOzcjnz5jXHk+dPUfTC9QXQzH3ygYNl8QHIou18MRKK2RovyayNri5n/CNngNKOxNejN9JwsOUqmo=@lists.linux.dev
X-Gm-Message-State: AOJu0YxdvHw1fEctFeYT9RfVuJ+v74nYFe35YjmzSar5lGR1pE0uaAB5
	hNjVRgQgv3tWX9iu32gYdV1vNZKetJnRNC0H46/duP85pZhaKVUT2xfg
X-Gm-Gg: AfdE7cnls2yJNWCCisUZXKTAq5bJo7IIrFxT365L8QxIE/8hO9rwWLa0FZvgeKaQjSN
	0++u1WNtjiXh6b2acVapw4cU3CYqTxXv6EaMh/c1j9BSLcibSvCodFw6MVlTP0ZrmmyXTrWvFe7
	aOGH1zAL0D/O8fk53vCvH7djnr8exXZ3n+2vDqz1P+athyLB6CArxgzTEWvchiCVy0dm8boqPoB
	sxEcA8qx0YBSrF00ndSTyqHpuXauuKCCYUYwbiVMjYp0hGc2GyktwPZ2huNfaNohxg6T8P6ImYE
	CsvTTja5y7U+D+ehIeC1kC9EfgFoVZiaeAFngwvQeCcFALfQ3Joj4cbQgyJ8l2laZj0Au8zSXud
	NXjcfUkQWygo8eS+lR8Y2sUBMArCTOgDNDsz4RD9INkbRcAAkYKVsAwHLqfyYdJn2cjcjMf5VYm
	AhBg28CmBf1CPiCOMIkKg/USc8idezk/s7ccx3a9QU7WZxM+qJT6puprmjjGbGhas8Jw==
X-Received: by 2002:a05:6a00:f89:b0:842:2419:6c0b with SMTP id d2e1a72fcca58-84889637ff9mr9176103b3a.10.1783997233424;
        Mon, 13 Jul 2026 19:47:13 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84a4f29c7d9sm671460b3a.26.2026.07.13.19.47.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 19:47:13 -0700 (PDT)
From: "zhidao su (Xiaomi)" <soolaugust@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	"zhidao su (Xiaomi)" <soolaugust@gmail.com>
Subject: [PATCH] sched_ext: Validate cid override before updating tables
Date: Tue, 14 Jul 2026 10:47:04 +0800
Message-ID: <20260714024704.3318132-1-soolaugust@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

scx_bpf_cid_override() currently updates the cid lookup tables as it
walks the user supplied mapping. If validation fails midway, earlier
entries may remain installed.

Split validation and table updates so a failed override leaves the
existing mapping unchanged.

Signed-off-by: zhidao su (Xiaomi) <soolaugust@gmail.com>
---
 kernel/sched/ext/cid.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/kernel/sched/ext/cid.c b/kernel/sched/ext/cid.c
index f31113b080e9..9e3a466f296f 100644
--- a/kernel/sched/ext/cid.c
+++ b/kernel/sched/ext/cid.c
@@ -329,6 +329,11 @@ __bpf_kfunc void scx_bpf_cid_override(const s32 *cpu_to_cid, u32 cpu_to_cid__sz,
 			scx_error(sch, "cid %d assigned to multiple cpus", c);
 			return;
 		}
+	}
+
+	for_each_possible_cpu(cpu) {
+		s32 c = cpu_to_cid[cpu];
+
 		scx_cpu_to_cid_tbl[cpu] = c;
 		scx_cid_to_cpu_tbl[c] = cpu;
 	}
-- 
2.43.0

