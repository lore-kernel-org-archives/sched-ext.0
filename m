Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF96B3A5E82
	for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 20:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774557766; cv=none; b=axGPxb0gthPyP5r/K4ra979LBeGsgiIOJ20aFXErrjcRui+M9GjLm+AUI5eXO6J/R+c740XhmOIGH8sB7aXnZXecDNXd4WIFzYKdtMT3GH2ihBctRUTt/tbFtrb2UzW+DAcibPaB9hoEyBFUXMQtX9SiuIaEUm+tGEHWwiV+02k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774557766; c=relaxed/simple;
	bh=oPDQGy2f1l5GTsk5Xh/BYrhKM9p7ZeZJOlWJ4aG085Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AlKW7Pz8EqFvNxqAJ1iG3d+4Ot5TCuI17vw1REB9WPQZuinpHI26FbFcnGuzao6Z0zZlDf8YsYqf9FWdmJ/Sr9MJKwZ6i24YTnP8Yt0MkT7YPTLCIWdUTpnKeMuT97QvOXkTx39p7DE4iR7YL6GzZD/WC9FwZbHwj/6/dKNtlcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CFImUp7W; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CFImUp7W"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2ab39b111b9so6333935ad.1
        for <sched-ext@lists.linux.dev>; Thu, 26 Mar 2026 13:42:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774557765; x=1775162565; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=2N2/7wqng5jasMv8jH1+uJQwqjxMU3RCq2Tk7FN2sLo=;
        b=CFImUp7W5jdUZ59QaN7bZqHkaJ+zdDWvGoHKWEpMTjPcDNkPlGzvxqlEpMAf/hMxH/
         7IACqzXFTC2iK+uyuwIHtN1ITHlpqxGqzEyGtLh8C8jXVwOGpKGXu3dag2v/k6sN7s1O
         VGKtiADd6K33DU4kORQjOMuZhET9FQYStR+f49Kc4UEGCtaAmbd4i6iaYGi1FpsqRjqV
         zbKQMwaA+X0v7lbUDooYBH6jA6khBnYJRxnZHh7vIY4Ks2e8nhn7b8/BQcg+LF+prG7d
         QUP4zr/8TbryittNwiQhG4TZAIonCJ0bXI1Cnil9apGxHnPJk3nG3PMx9kYXDLjmb7tz
         t2jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774557765; x=1775162565;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2N2/7wqng5jasMv8jH1+uJQwqjxMU3RCq2Tk7FN2sLo=;
        b=KKK2t6dkbVtx7OB9V/HVFBYaX/H+tvETP0pcFaSH0flf4QHMo/Uk/l+ZOaAPqtxGRk
         B7F3y3nks8VRVJZUkUc9N+k1PcUt3VeeP9ZuM1g9rggWZUYcir0AVIR6gRzJ4YW0Ki7V
         ZQMD7CSZeZmeQPRQ1hClkB/PyAyPTcRUJHif20R4+++fDvIMDuV0KSdnDo56SygniIHX
         mhCCCCrALsTOXaAEp73lhyu7r8fVcjyE/spp/LpNnx+gS0QHjfIu3sMG40yNy+deciYg
         n8Rr+ENuTnuu12vCMUvJbmBa5zVnBTJasP0i1y3uAwFdgeGraK2Amzb1Dpm9oX9L8GkH
         NQDg==
X-Gm-Message-State: AOJu0YwoqYm977WOXZbHUIEPFsOgX/mYrsYoQi5gyhGaSuuCQ2TNiYz1
	wqBM3t/X0PE7OsPBEFNcMI1bvoJMsb06lEqf8tYkBr6yGSbtflm0tNXN3lcnfQ==
X-Gm-Gg: ATEYQzykmqFo47Ixjx6q6cyrIgnMywXIhDiQs9wgQTs9D3+oXXwYpj0S53yQUbhlTyq
	23PR9m08FzjwJMpwd1JefHs26WoqGzYFn54+oLsqPVFBJsa5ORUHvgqXHHJNchhJB3Nr7fM1JZK
	oD4octJbBu4UTCljrynxCMqeogbM9vLBC69mdLFHzGw0yjWcO468dyHXxYwsr4ZLeKVsP14h69v
	6+SOYNlaEnt7nDjDM8MpxPDcbfDAaVhxCtn4uqGZQYWfRQ5dhR+6sQAIpD0b/iqyk3kT7c46DXO
	984DT1EIcfjmuMzx/t0Jx6+xPKyN3lTS2Yx24NOKu4LFVm4MtbZqXFKx+xk7+wyPu9EXeGOXqgP
	Fyl3+D1+ql2brfSYeh4WsrJ/YbaaF6pO0l1UIBrAE15uEhrXjINn/BODLgWErZX/MOyHMhItiWl
	cOkwAZT98aQfF/9qQsgdg3Z1L20zDr1UbLmfVGqMqoOloFOJGsm87XLmy/9+7PgmJgR+uNo5+f5
	sY=
X-Received: by 2002:a17:903:b88:b0:2ae:c862:3a2 with SMTP id d9443c01a7336-2b0cdc2cf09mr202085ad.17.1774557764854;
        Thu, 26 Mar 2026 13:42:44 -0700 (PDT)
Received: from mi-HP-ProDesk-680-G6-PCI-Microtower-PC.mioffice.cn ([43.224.245.226])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0cbfd17d9sm4004905ad.25.2026.03.26.13.42.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 13:42:44 -0700 (PDT)
From: zhidao su <soolaugust@gmail.com>
X-Google-Original-From: zhidao su <suzhidao@xiaomi.com>
To: sched-ext@lists.linux.dev
Cc: linux-kernel@vger.kernel.org,
	tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	peterz@infradead.org,
	mingo@redhat.com,
	zhidao su <suzhidao@xiaomi.com>
Subject: [PATCH 0/4] sched_ext: fix three unreliable selftests and compat kfunc signature
Date: Fri, 27 Mar 2026 04:42:34 +0800
Message-ID: <20260326204238.3755737-1-suzhidao@xiaomi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Three selftests added in c50dcf533149 ("selftests/sched_ext: Add tests
for SCX_ENQ_IMMED and scx_bpf_dsq_reenq()") have design flaws that
prevent them from reliably triggering the kernel behavior they were
written to verify.  This series fixes all three, plus a related
compat.bpf.h signature bug.

- Patch 1: compat.bpf.h declares scx_bpf_dsq_reenq___compat with an
  explicit aux__prog parameter, but scx_bpf_dsq_reenq() is a
  KF_IMPLICIT_ARGS kfunc, so the BPF-side declaration must NOT include
  the implicit parameter.

- Patch 2 (enq_immed): when the IMMED slow path fires, reenqueued tasks
  were re-inserted into CPU 0's local DSQ, immediately re-triggering
  the slow path and creating an infinite cycle that hits
  SCX_REENQ_LOCAL_MAX_REPEAT (256).  Fix: redirect reenqueued tasks to
  SCX_DSQ_GLOBAL.

- Patch 3 (dsq_reenq): dispatch consumed USER_DSQ directly, racing with
  the 5 ms BPF timer.  By the time the timer fired, USER_DSQ was empty
  and scx_bpf_dsq_reenq() found nothing to reenqueue.  Fix: two-DSQ
  design where USER_DSQ is never touched by dispatch.

- Patch 4 (consume_immed): workers were spread across all CPUs, so
  USER_DSQ usually had only one task and dsq->nr never exceeded 1.  Fix:
  pin all workers to CPU 0 via CPU affinity so USER_DSQ always has
  backlog; add dispatch loop to accumulate 2+ tasks and reliably trigger
  the IMMED slow path.

All three tests verified with virtme-ng (PASSED: 30, FAILED: 0 across
the full sched_ext selftest suite).

zhidao su (4):
  tools/sched_ext: compat.bpf.h: fix scx_bpf_dsq_reenq___compat
    signature
  selftests/sched_ext: enq_immed: fix IMMED reenqueue livelock
  selftests/sched_ext: dsq_reenq: fix reliability with two-DSQ design
  selftests/sched_ext: consume_immed: fix reliability with CPU affinity

 tools/sched_ext/include/scx/compat.bpf.h      |  4 +-
 .../selftests/sched_ext/consume_immed.bpf.c   | 19 ++++++--
 .../selftests/sched_ext/consume_immed.c       | 15 +++++--
 .../selftests/sched_ext/dsq_reenq.bpf.c       | 45 ++++++++++++++-----
 .../selftests/sched_ext/enq_immed.bpf.c       | 10 ++++-
 5 files changed, 73 insertions(+), 20 deletions(-)

-- 
2.43.0

