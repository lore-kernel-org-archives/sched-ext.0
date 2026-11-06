Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.214.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793988247;
	b=AgvvB48iNJtfKZ+bkbIJr8iEExuH99ILWdI3Bw4xh0sdArfPI8Ho7EM0G6iKM83W5+li
	 481Xhw04Mnd7KMTbVI03WEb9w4NyKcVn1KFIT4G4TT0HQs1AuhYKM0yus79aAy7ZMbgjr
	 TUubSxgytsdjT8XlSLoKoZoCmNj/xZPKfmmPZXGDsF+IO0buIEIN2ysvVwavD4wzxpgVU
	 /LKfuYQROw0OGtcUOp2ZqfYUsMVYJIMBeKHfMjIugpupXBICApyDRYpjmKUhWOVWF5ewj
	 x9xiBmbrQtSUaz2oLMJkV4ez+WOTgtE5ixf84F0GDVhU7sNv+sgBlUXkMxuQpwEYRyw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793988247;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
	b=GlqW2kKwJ1Kil92yvHH0gvqxh4R5MGJA5R2h96pr+E1ZMvrlaqt+s/+skQYxt3TF7/jO
	 JfbAiDsDMpVBT6arz+cOYSCgXa/WLgPUx7ru5CRFOTm1X/oX4e7QReLmYFZ3MLf1d3trl
	 afN8ucWYmmcPLQ9vS2Y0qhhn1DlvOwtT6ExwEwfBYldk0+/hwkN/Atr0ETur0pFEYs3BH
	 bjWNs/JNlAdrRrT07+5lj3iY2NnudmzUlu2khuF52DaVisC2FuQ9wIp7iQHm0aiBCjCrM
	 +T+TZM/vamBzbDB2oa6wc6aBSJrwEZU/hGCIeTRWvu4gantsG8M0mXxczrbQTz7jVLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8basOOT;
	arc=none smtp.remote-ip=209.85.214.173
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E781606A32C
	for <sched-ext@lists.linux.dev>; Fri,  6 Nov 2026 18:04:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0E781606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=M8basOOT
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-2ed1b9e8f43so4036885ad.1
        for <sched-ext@lists.linux.dev>; Fri, 06 Nov 2026 10:04:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793988246; x=1794593046; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
        b=M8basOOT9Nc+C7xQpr4RwNYT3qpR0MvZ1HT5ECUH+frqknBlEhLI/SARg+7UE+RtZ8
         KB+2SgbTkrdO6NJDuxBNVJL5SV50E6QGe6PI2IxaBTrU3N9cCzLrixO7ZDfpYC4huERl
         n+SdBytYaVpd7U5WNLJy85Trf9ThVXTViT2TrF7hsYw4oJ502kyhWt9Uzt+NnK3crMl/
         D3VEQXb5RlBhCehNJYxPkZZ1eZXX6vO3UMfSwPrQngEe7E0s7s3zGRVV6/HQxXw1+LBW
         t6euzJjPtqC81Sg/8YDmsGILtNqJhDsvwwMRzveT8BIJw/fRKd4N17YUQNSJ7rohgWLC
         qDdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793988246; x=1794593046;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=ff87flfpWxQA4dJrc987lusQnFIhkWINyfHTfPBOik0=;
        b=cTGFXBnJU6Yjpm/SjcS0arVgQ0pavupjkwb3W2c9rRn/aGGSNrKkTXScd7o/2rDo2P
         TUfkAyLwyKam8TM3TAEEjRFIen1ZQgeh1NTt94CIqmzUCyK8jlzoN39f9vM2SI0872yq
         PzvCN8++OhGkL3jJeuyj0kMrrIF9u3tzsBvaLt9mTToqPuzFq1vVhJTbHRs01aFv7C+B
         y3gwUQ4RorHJabgXIjCpSjxorShy3hfl4BmJVnZwvc2ldzUZUjz3pJV3wcJLZAR9+k6w
         i4ppc2hKfd6B1NngdteCiZIMojY6Q8xEMVyVdRQ8mUds3J42euh0H7bKey4VoHl0iU0k
         FrYA==
X-Forwarded-Encrypted: i=1; AL+hErHdDn3xEgeupkX/9AR+JuSkGQbelnj7TGrL6yYS0dcvOzesyu0QAChBKdHFsFJWhyw/HmgvXhr72KU=@lists.linux.dev
X-Gm-Message-State: APuU4Z9h5mCfcLMIiOlbSi/UJ0bQF/NL0zcJ/kpjkkX39Iiz2pkBFv9X
	D+54b8zee8OqW2SRxb7x2y8klg8gxLLd0OpPvzvvfleejOkaVYhvBfqkqoYz5g==
X-Gm-Gg: AYBFou0ZlXfcw60tu7QvNqai7UV0+nHdlBZT/Ie3jBM9xek/BtZ7HKMrD2X8YXD/SvB
	JKaTrsvMvMspTJDS3hbXIomQQiCFk3r2Kcv4OiQUL1rucp/4n1XboyNrMGpL5oxBe88P4xAmC8P
	ezcak7h8Y+EvBv8b9wfgVOXOVOx1uSnYoBpIvsLOWcWfA/04+gOlHTjyhNx+SaLntYkTGhqgavU
	gflfO0npgddHCDGxVYC5z2P6TLUlfYbrseF0uy97NWkUrcmQaHFrUA0Okfqco3/7YN5Kzp8mWKa
	QM2CawmXqq4tMELcnU6Q3JrtC2CR/ymphZT9bXTf5b/0Ng/SzuyYs8khonNGuleDwQcUPzCmNOH
	CeCRtCMDGZ+mHTAJGptlvq0rxq1/fdL1KcaVKH7ZpT650q18R4imqDN/wG+/VExdV5tC7kCLj+M
	toX9uXpfjoUEdR8yG1L9rBIo2U79/NqUA2kkTXYmTpPcfVFtX9k4U77Q3AY/00loW2EBQ2BDqSm
	xkmCUPvP8yDNmKHhhfCwJFirwbFqy5iki1gW0dPAUFvP4xZOb4HLMhZ2bezH4djbNlB/6po6syH
	jGOEk/7SM4LcTwU2mHZXKw/CNfw35gxLaLXjIS27eRFgdiUGyDyX05HrQHs1WzzOHkF4KW5w9A=
	=
X-Received: by 2002:a17:902:ce03:b0:2e9:6790:212c with SMTP id d9443c01a7336-2ed40c494f5mr41103385ad.30.1793988246266;
        Fri, 06 Nov 2026 10:04:06 -0800 (PST)
Received: from DESKTOP-31QBR7C ([103.120.166.85])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ed47da165dsm8057515ad.73.2026.11.06.10.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:04:05 -0800 (PST)
From: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
To: tj@kernel.org
Cc: void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	Rahad Bhuiya <rahadbhuiya2021@gmail.com>
Subject: [PATCH v2] sched_ext: Reset task fields on exit of an SCX_TASK_READY task
Date: Sat,  7 Nov 2026 00:03:53 +0600
Message-ID: <20261106180353.457-1-rahadbhuiya2021@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
In-Reply-To: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
References: <20261106142818.1475-1-rahadbhuiya2021@gmail.com>
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

Tasks in SCX_TASK_READY are attached to a scheduler but outside the ext
class, such as RT/DL tasks, or non-SCHED_EXT tasks under a partial switch.
The scheduler's BPF code can still update their dsq_vtime and slice (for
instance, via ops.cgroup_move() as done by scx_flatcg).

Because __scx_disable_and_exit_task() currently breaks out of the state
switch for SCX_TASK_READY without calling scx_reset_task_fields(), these
fields are not cleared when the task leaves the scheduler. If the task is
subsequently moved to another cgroup/sub-scheduler and later switches to
SCHED_NORMAL, the new scheduler's ops.enable() sees stale dsq_vtime from
the previous scheduler's clock.

Call scx_reset_task_fields() in the SCX_TASK_READY case of
__scx_disable_and_exit_task() to ensure SCX-managed fields are properly
reset when leaving the scheduler.

Fixes: 5771e79e461e ("sched_ext: Reset dsq_vtime and slice when a task leaves SCX")
Signed-off-by: Rahad Bhuiya <rahadbhuiya2021@gmail.com>
---
v2:
- Rewrote the commit description to describe the cgroup sub-sched / RT task
  migration case (per Tejun Heo).
- Updated Fixes: tag to 5771e79e461e ("sched_ext: Reset dsq_vtime and slice
  when a task leaves SCX").
- Targeted sched_ext tree instead of bpf-next.

 kernel/sched/ext/ext.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/kernel/sched/ext/ext.c b/kernel/sched/ext/ext.c
index f74ffb3b1aca..b57a7989f304 100644
--- a/kernel/sched/ext/ext.c
+++ b/kernel/sched/ext/ext.c
@@ -4728,6 +4728,7 @@ void __scx_disable_and_exit_task(struct scx_sched *sch, struct task_struct *p)
 		args.cancelled = true;
 		break;
 	case SCX_TASK_READY:
+		scx_reset_task_fields(task_rq(p), p);
 		break;
 	case SCX_TASK_ENABLED:
 		scx_disable_task(sch, p);
-- 
2.55.0.windows.3

