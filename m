Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02832E88A4
	for <sched-ext@lists.linux.dev>; Thu, 13 Aug 2026 04:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786597176; cv=none; b=bsTC3rMHUUDgashxNK6Rym5LnjNug58sBC2vQQ1pgBxIAsspRdEtwcUpH8zzHJZy8YatXPqtVxNv+SpCqSHPKkCd/KEb1B+WbA0T01cLIALYCT09V80Hsa7YrZEytjNQnytVE1vYHq+HYf1YUhvHiG/2WIyBFToi5s07yIojqw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786597176; c=relaxed/simple;
	bh=FhI6XOqCG/rHYjGkvA6Un2LtD5OD7jkFQjW1/WgtJhc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tiglv+HQg3HCL5Pa7OUkJN6bSXA/lHlYsSVCdkallFcnRy3M4E6xGbXV/00nb7n56pE0pt6vHy4h/pDfTRT5G7litod7NcgLNmr/XC7v0pzrnG/C3eJ9YEpci97NPvGhBYv2OSGT1HY3F1N9h4nH6kLI/Cx7V47Jg+6eeqbwDl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ry6J87NN; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ry6J87NN"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-495437bb891so4375565e9.1
        for <sched-ext@lists.linux.dev>; Wed, 12 Aug 2026 21:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786597173; x=1787201973; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=RldXtKBhaRt2S6l0z8oiQPCcZO7pKv6jWrFv1/cNys8=;
        b=ry6J87NNOuxVvH+zOzijbfOW3bCldjbEhk/GfBi+L30O3FfRz03veWy+npvBWc8VsB
         ZD/PGM7xl3W4pxovCqriLfP7HB3Z0TU5FYFVRuTskB/mQQ0JCE5JaOqESUPiZ4HAFb7t
         gT7yIsNdDH/AsKsNJep3J7ioTORoOo582cbCZs5oKWHHXfhPQxdEnZTQz8wxBd1rE4op
         3YT4udDdDmwEqGi2FLuSX/HSNeBzoKJK1gfMV5cJr7OkhfLUUxA4hnci7JqilhM/C/GW
         qP/MKTpCE4ypF/j6/7XyskyjlAd72EDFT/j6pHxf72uILq/s/w8x8CiD3Xorm5SeTWj4
         q6Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786597173; x=1787201973;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=RldXtKBhaRt2S6l0z8oiQPCcZO7pKv6jWrFv1/cNys8=;
        b=qgvwQiUdYFbrug2xLnkfmte2ZdknBIJSpBzVJ6+Rh2ivjkWYxDQqkXc+y90Q4bAlSs
         STH+vOfo8LM6sjNl4dz76tF6U7S01vZO7dwKfIk9Tf99iQo1dMeOQidSEX0A7wcKd4+k
         D0M3pquBpSwDKQ5JkWDVgRnGhZUSDIeKLwC89IYpxi9HXNCZi7+/lJLE2+y4o9GzY8dr
         kQ23k7QPMkBIweCHkYbLAyfQSczflSA4A/M/YpaXf3XnelMfbD0MjoN6XyqfhzIpMo25
         0HvnYNEDHqaHdxVyHwi0qB4ux8V4pXLtBDIlWihZMVfbqSC5m3CwhMQczF2ef6SMKa0S
         G3/Q==
X-Gm-Message-State: AOJu0YzCIOeMUu7xeBWmrtvPnvXSMPKD1llvtPJlqxg1S5nRA9HE8frk
	TAH5U5duy/cQnbYdZp9f7pvLIIopWGuJo//USApbDPXCjFwSuOXr9xKjE1D31VQeqNE=
X-Gm-Gg: AR+sD11tRCyVSmH9ge8rX8gEb1mxBe2eYy0uHet/W28/mwIMv6j2y7vbidF/Zfv05J8
	hwMVzDiQormxKJQWirVrT8Hs+rXzwQ6kqZnQviBaQEWeItrG4/jSMLOcwpFZNWbAgeqnirac6Ux
	crvolWfxKihNmWmalKOc9jLS+BN/1eUbR2fWUQ4ZoGq9pCxzLTbQxcz4krkylKjaygDQj5KMuMi
	5pBW8seY4Rpac54tN5+oU+wV8h72+VR3XQF79U61G1Rnj4clZ/1QkTBzG3vZYyvKiAGc7yJ0yGl
	1/u1Y269vTUFgYtaGDh/a9xh4ZW/6hfqNOHL1EPivBdOS4Vc7FaeLcHwdRwJwyKX35os/5D7PUz
	DO3hF8cT9WFEJRU2MITbX5BeW80QYAF5o6y3Ks8MD+7cAhpUPiRRqo8vN7iQJ/2P/HJJRU8W7Q/
	+JiYw6LEYD/h+8EO5RxAe8N3sxdMiuGUK8t6xtoZ8MgD0NlVyqHtKJj3O5KKidsMQco93SqZMe5
	zLHmqNWK2Hp0wet2myhar5mEYBpm5Rbk1AiQwijJx4WH8svdvuI9SMBFTg=
X-Received: by 2002:a05:600c:c87:b0:499:810b:6f57 with SMTP id 5b1f17b1804b1-49982200fa5mr17849475e9.4.1786597173022;
        Wed, 12 Aug 2026 21:59:33 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49981b6abbcsm36671835e9.15.2026.08.12.21.59.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Aug 2026 21:59:32 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Tejun Heo <tj@kernel.org>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: [BUG] sched_ext: ops.sub_ecaps_updated() dispatch context is set up on the wrong CPU under core scheduling
Date: Thu, 13 Aug 2026 05:59:31 +0100
Message-ID: <20260813045931.8691-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

scx_process_sync_ecaps() looks like a missed instance of the bug class
3dd52416e44a ("sched_ext: Fix this_rq() assumptions in dispatch kfuncs")
fixed: before invoking ops.sub_ecaps_updated() it does

		struct scx_dsp_ctx *dspc = &pcpu->dsp_ctx;

		dspc->rq = rq;

where @pcpu is the *target* CPU's context (recovered from the llist node),
while the dispatch kfuncs resolve theirs with this_cpu_ptr(sch->pcpu).
Identical until dispatch_core_pick() started running balance_one() for
sibling rqs - now a sync processed by a sibling calls the op with the
executing CPU's dsp_ctx.rq unset.

Nothing ever writes a sub's dsp_ctx.rq on a CPU before the first
scx_bpf_sub_dispatch() there, so it is NULL at attach time - exactly when
the initial cap-grant notifications fire. If the op then calls e.g.
scx_bpf_dsq_move_to_local() (it has SCX_KF_ALLOW_DISPATCH) on a non-empty
DSQ, scx_consume_dispatch_q(sch, NULL, ...) reaches
task_can_run_on_remote_rq() -> cpu_of(NULL) and oopses in the pick path.
A leftover rq from an earlier dispatch instead consumes toward the wrong
rq.

Fix seems to be a one-liner matching scx_dispatch_sched():

	-		struct scx_dsp_ctx *dspc = &pcpu->dsp_ctx;
	+		struct scx_dsp_ctx *dspc =
	+			&this_cpu_ptr(pcpu->sch->pcpu)->dsp_ctx;

with Fixes: b81a6c018cde ("sched_ext: Add sub_ecaps_updated()
effective-cap change notifier"). Happy to send a patch if nobody is on it,
or feel free to just fix it directly.

Cheers !
