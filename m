Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B1215075
	for <sched-ext@lists.linux.dev>; Fri, 21 Aug 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787292978; cv=none; b=OC+fgvPOXFebCe+SXfWG0EaaoEtt83+FPIJ0IXB4QvumdTemKHLlHNcWmXKcn9NyNIvc2/3IpSaIh66APSLzgiFHdUdvTlonak+JKrYVggau+3hEZSFgSi6+goh1payvDBrGWBFRFIe2EMm3LtKAy4m0LBHgSsz6yU9NSAfbtiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787292978; c=relaxed/simple;
	bh=01Q9RmN+OOG8NquUjicIubTaL5hG5FHpom47jCQMsFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nNdKFfi70ppUIa3ckbX0PwbY4KyS+E7BNdXu2l+mrmS3pC6UfHTD5bcsAs2eRk5N4C5LJNge/J6/xZo5hHs79eMuMIVBM95C0/W8OzO4M5aOTSFLKQd4qgvbb8ESMPIbuKrUF+Tu0ClRFY0czEsKZbbnhl6BLxbM9ZVYEz58Fkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IVC1nO4u; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IVC1nO4u"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2d530328efbso6024315ad.0
        for <sched-ext@lists.linux.dev>; Thu, 20 Aug 2026 23:16:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787292976; x=1787897776; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6hJ/xBbix/1nmIFPMSZeWh1GNhMvGujT1tgCK301Z50=;
        b=IVC1nO4u4oj5F6sWU4RY0pY5SCOZwKKMqTQu0PIBMJ3dVZuU97Y/GG+aKfvSZzIZ1b
         +dPwptL1OYqhMbLAZiH2PcAvANR7uLnFVw5W2Q1LaMZgkemF+wY0fBOdk2V0q+AbYvE+
         9EICYu3XhrQcXRw8ruH5fujH5Zta3LjTIDM+befEqaZT0FukGVE1Fq06vbX3hVEdL6AV
         5jRcfraDlZOAxbw2Dsw0BeeJ4BDT6wrNzIqzUj4/xCKI2jSwY/iZI92r5Xiut7WC9L3L
         xOCvhqq+I1cd/qRl9nt/sCrdnBpdR09ES3cJKJgoLiRXeESqvxQfE8JCNGXIwnvoKluO
         EWjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787292976; x=1787897776;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6hJ/xBbix/1nmIFPMSZeWh1GNhMvGujT1tgCK301Z50=;
        b=OpqzKW42/VS/JZCeMRMG0pfUC/XVzmPlQk3rUJcn8M85W2dL0v4I+TgYrY0eJHgPqk
         LznRYpmZYm+WDK1sD6Qz8Yfvvobn70yIXPFWhGI/RHeAWLW7uedj/baCykWUihPypSgR
         SAtUVmxUrtmCHJuKa6zyjWzfhnlUB9JWvmOvVv+wK4p+mY6VeGWW53J9ia0yPraPTREi
         gdlfy1fmV8pXB+89PoPGeRbLEIGbC0llRbIWDdcnQY7WcXrXS+bp4YccFaXxBw9k1g2Y
         5685oaFj2gTGfcUCBIq6saeWYFIWRnPVUoYC429DWCeXKBQ2WMj+ra+jvknu0ayBTDBd
         B3JQ==
X-Gm-Message-State: AFuF++mSgOC+CFyOpE7TjWTPGwjTxr7AR7Us2rAnvm9pyJrD1gytaogY
	1bjk10DP+BqIhMcnK/8H5sBwOxIzM8vJlKymcKqdtz4NecD2hWcurgaVMVB5zVe5
X-Gm-Gg: AR+sD12jAfCz+fTkPZEHQoeyq/fnh2psxolUY1klROJoqZP7aBblK43nLbR5YcA42uL
	3iEk/8zyuIw3pgBSVMnPGykoXm2E1KYL9KIIixVCfEwJ6Nm+IQCDWimPrvMxM1ggoZa6qiQKEL7
	Nl+pgNIyzvFuwg4uCn/RfkOYTcnAqVHOIVFuL/aKbZJaGbNMsxU/MZ/l6BnSghRzMoZOv6uBjGY
	EhluoesNMbDeFAGu6IVkVPhd5d6MrmMlAjMINrYl2BiT7x0l8z1uQmZlXV2l1rsDhOQPnXYoVVy
	303OcjCCNRu72mhOzcBB57UI4EZNDJMzUjPGRzRnkS6uBCk0PNp/JKDjYehalbGIq/4iJLZnh0g
	Jm4zbt17U+ZQt4xPPabVn1E8kgkSIu5jRsMFBmFfcLmUBVVXF62PSm5IZ7QBzuFjATvCrcmPX5W
	HvJKVpsMxmR7/tSlHbtRpmjGjeDjdBb5T77QS71KpgRU7M4LYqlJLzmHfpQFJ6TWQ3rUJ10x7a
X-Received: by 2002:a17:90b:558b:b0:37f:fdc8:71b4 with SMTP id 98e67ed59e1d1-395c33371a9mr8062450a91.2.1787292976085;
        Thu, 20 Aug 2026 23:16:16 -0700 (PDT)
Received: from osman.mioffice.cn ([43.224.245.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-395c45539a1sm1765801a91.3.2026.08.20.23.16.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2026 23:16:15 -0700 (PDT)
From: Zhan Xusheng <zhanxusheng1024@gmail.com>
X-Google-Original-From: Zhan Xusheng <zhanxusheng@xiaomi.com>
To: yaoyiqi3@huawei.com
Cc: sched-ext@lists.linux.dev,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	zhanxusheng@xiaomi.com
Subject: Re: [scx_nest] bpf_timer_cancel() unusable from select_cpu()
Date: Fri, 21 Aug 2026 14:16:08 +0800
Message-ID: <20260821061608.1987231-1-zhanxusheng@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <19aa0be21ad34c6cabab7cc8b26d4656@huawei.com>
References: <6aecefa9aee94aa3a029b66f91692e7c@huawei.com> <19aa0be21ad34c6cabab7cc8b26d4656@huawei.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 21 Aug 2026 04:22:26 +0000, yaoyiqi (A) wrote:
> + if (!pcpu_ctx->scheduled_compaction)
> +   return 0;

stat_inc(NEST_STAT(CALLBACK_COMPACTED)) sits above this, so the stale
expiries get counted as compactions that did not happen. The counters
also stop adding up: the cancel in migrate_primary() takes
CANCELLED_COMPACTION, then the same timer still fires and takes
CALLBACK_COMPACTED, so SCHEDULED_COMPACTION no longer matches the sum
unless the core was re-armed in between. Upstream can reach the same
state, since the callback clears scheduled_compaction only at its end and
a cancel can arrive while it runs, but there it needs that race. Moving
the stat_inc() below your check would cover both.

> +    * path, which can run with local IRQs disabled or in hardirq
> +    * contexts - not merely "non-sleepable" - so the timer cancel

I would drop the "can": it looks unconditional to me. select_task_rq()
carries lockdep_assert_held(&p->pi_lock) at kernel/sched/core.c:3626, and
the paths reaching select_task_rq_scx() all hold that lock with IRQs off:

  try_to_wake_up()    scoped_guard(raw_spinlock_irqsave) 4302, call 4403
  wake_up_new_task()  raw_spin_lock_irqsave() 4957, call 4968
  sched_exec()        scoped_guard(raw_spinlock_irqsave) 5639, call 5640

So it is the caller's lock rather than the wakeup being IRQ-driven, and
sched_exec() is not a wakeup at all.

Thanks,
Zhan Xusheng
