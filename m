Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA8A35CB89
	for <sched-ext@lists.linux.dev>; Mon,  1 Jun 2026 12:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780317721; cv=none; b=N7gD4ujUtwnSXlNCSn5EmVOCebKkJZtwCg/SHrkNCAORQ1uicY0khfx+qG7gq/oF75cpI1BjZyinrSkt75rGTAXatLrn7SlMqjpUxMTHh4vvVXXOFND4MDUuhMtBme3pxByI2zFUEgMouCa34fiqe1y54OFtatsOuKbxkclgpRM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780317721; c=relaxed/simple;
	bh=fSvt1vasSY/G30ddgDrjyy8+zV9Vlao9wYsxECgQ4mk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=usI6+2ZreMOpvBYlHHOyLbX2A/1XzLXdv00ksrRNYYOLDYO0pTX4pC0YRYvZr2xG1QW6p2KM2gCwVPtyreq2fyOJDb8Z/PKDvCfUmJEAilNPBm0DTgy+AMn1XKVotNhuL4XueMji9Hqz25GwjYt0E5uCTbOZ1A1q1tAKNhmAb/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com; spf=none smtp.mailfrom=readmodwrite.com; dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b=KL7klPke; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=readmodwrite.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=readmodwrite-com.20251104.gappssmtp.com header.i=@readmodwrite-com.20251104.gappssmtp.com header.b="KL7klPke"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4903997fcb5so103760575e9.2
        for <sched-ext@lists.linux.dev>; Mon, 01 Jun 2026 05:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=readmodwrite-com.20251104.gappssmtp.com; s=20251104; t=1780317719; x=1780922519; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gfyPv7a96A4SDDYDoTWoVCAL2rD5vN2GwJzxHozmv94=;
        b=KL7klPkehybHeNoCv1KwXSgQgnad8m3fmq38zmmfm9GxrNLjwav/atxZx1mDxIWg53
         ElG3yZvs0FRLjEJYK2tS5mW8a0xVQFnUUvNaSIywhxGOEdP5nC7MJexsCh1oYW2fASG1
         hi0FLd39ifC3l85RylWIhwzoJ3iTZfsbhzOLbOvx49v9hxhX3yuuMlUjJKFQuZ46t+Bk
         7jHeECq1GJ9Zz0SuoCCxFfr2Jjdf8/iCgtz5K1RqmlJ2Ig6oK17Rzyqqc6OegV6yqXwp
         U0vecW/70ZeXRMq4MYx+3ylywqH/N0jywNHusw7hviWWTORbMXdVUknYKCWTaXKGqOSa
         g7Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780317719; x=1780922519;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gfyPv7a96A4SDDYDoTWoVCAL2rD5vN2GwJzxHozmv94=;
        b=VjrJCFdj+LtNpJv6HLOSmnawBll+Hz3ddahX2fHxVNb5YuwHfKzVWetTX4FtmPXItA
         x/TKeE4urRL6dOcudE4Slgf5vVCAI3xyY76VD1V0cy6vE73XrD5yLzhiNn6nPAQNMYG5
         AG9Sowge6XGSeOYGtyEMBvcMzgaoA8e8nzWEoYfDtm6EGREck8MzWEw5w9JthXg/+8vo
         BF2xhjhl2G/mipjdHLn2zxeCSXra/DfCPGHGglJkVLm3B5UKZHHEFtvHpjxo9AWVm+jj
         fZH1TS/U/67lppM+f3bPKW9X897gdo3rxpAtgVyJPy0Uk+0zaP65C63odiMxmyBtfBhr
         XVQA==
X-Forwarded-Encrypted: i=1; AFNElJ/+/LjcFK3QeKniVEUiTJ2wFiAzWYQ93FQll0semUF9N4IVEabAadeyM+YF+kKdoNu5IVEVEzLcCqY=@lists.linux.dev
X-Gm-Message-State: AOJu0YzzvDhJ3lqApdVepHguDIAnNPcHt9cw45c+6i+lXOlMRQ8sUgVG
	qk1lA3Np/Gcmh8+OjdxZNh8htSWJ3ei6fYFi16VzPP7lrflSn8TJRwkpII5e14flEt4=
X-Gm-Gg: Acq92OFOlWgeJixTHjlNZtXEFX3zck/hR09Ik+x/p+jNLzv5moEonCdnef2QyQMgau9
	jVChidQGqDgV11QYzCd/gUQ7B49v/MjDSwMnnin+yRhGPDEkwBb61efVULU3hhfjv5A1g9JTxLT
	Riv73C7rOwlF6oCsV6YyAx3DAw/ildue5XlOvWsdgT0pfwJQ2IsWjIsGKgtejWE08NvlpMze+Fp
	HObrU6udbnkLkGjItgvkqmeWk0s2XU1xohvQfyPvIPpRt0IMa3JaPf6PsdlyAMX8MWjWCZAxPrC
	TefTMMz16ejqVW19cPKvxH1E1aCCZeh4A94YM9v/MnwggKI/hiYqdcwYzWR6JoUxk6Q1u8zg0uy
	BU8kyd+I9R4PvnuNFWMvMJpnuytKI5/VxV1gD9GdIWvlDPHI58SYIE9SmYp+Niov2iK58NDn/8J
	DzUGwLIyf5tusxdy/EnOXQ/CTdlzTd3RuLyWpUhvxAGS5JBvcXLQ==
X-Received: by 2002:a05:600c:818c:b0:490:48df:2793 with SMTP id 5b1f17b1804b1-490a296df9amr205353575e9.26.1780317718760;
        Mon, 01 Jun 2026 05:41:58 -0700 (PDT)
Received: from matt-Precision-5490.. ([2a09:bac6:37a8:26a0::3d9:2a])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34c50f6sm28006952f8f.16.2026.06.01.05.41.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 05:41:58 -0700 (PDT)
From: Matt Fleming <matt@readmodwrite.com>
X-Google-Original-From: Matt Fleming <mfleming@cloudflare.com>
To: Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>
Cc: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	kernel-team@cloudflare.com,
	Matt Fleming <mfleming@cloudflare.com>
Subject: WARNING at kernel/sched/ext.c:3227 scx_cgroup_move_task+0xa8/0xb0
Date: Mon,  1 Jun 2026 13:41:56 +0100
Message-ID: <20260601124156.2205704-1-mfleming@cloudflare.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

We're hitting a WARN_ON_ONCE in scx_cgroup_move_task() while running
scx_lavd. The stack is:

    scx_cgroup_move_task+0xa8/0xb0
    sched_move_task+0x134/0x290
    cpu_cgroup_attach+0x39/0x70
    cgroup_migrate_execute+0x37d/0x450
    cgroup_update_dfl_csses+0x1e3/0x270
    cgroup_subtree_control_write+0x3e7/0x440

The trigger is systemd's user@UID.service startup. The user manager
writes +cpu +memory +pids to its own subtree_control. Because +cpu is
already inherited, the cpu task_group doesn't change -- but
find_css_set() returns a css_set whose subsys[cpu] pointer differs
from the source (different css object, same tg_cgrp()). That sets
the cpu bit in mgctx->ss_mask, so both cpu_cgroup_can_attach() and
cpu_cgroup_attach() run.

scx_cgroup_can_attach() checks "from == to" in tg_cgrp() and skips the
task, leaving cgrp_moving_from NULL. But cpu_cgroup_attach() calls
sched_move_task() unconditionally, so scx_cgroup_move_task() fires and
WARNs on the NULL.

I managed to reproduce by cycling systemctl stop/start
user@UID.service. The hit rate varies with css_set cache state.

Any thoughts on the best way to resolve this?

Thanks,
Matt
