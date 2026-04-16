Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA97A379EE1
	for <sched-ext@lists.linux.dev>; Thu, 16 Apr 2026 06:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776322046; cv=none; b=XrImQmn1GRu7B96IxFeELZdBPyAUZGw4f8NsdkXr/JI3RbxQ2dhEfc6rGpyQCaXIAvnbhREOP8GUOM0N64sPyjOk/9V/MS/UrtnP22ZmmreRqfRw8HyMWxA6KXf+jht4drMPOVwh92HvtgGxpXiZOFKtgCZrp+k0Z8JfveQEUGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776322046; c=relaxed/simple;
	bh=gP34gHn4uPmrsaN9qnmZTtnWnjbrt/xZgXUEvCBplg4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CfGK93TrE4SrmTLQNYh+Tn225MoLNKZuOx3YceVP+cY/dpbvn0tiXIjtzRKodUynP8q+5fukvdRgwnJDGxmzttrF0TYwLVdl5jvfk9Jlo0vCdFRlJyMTizV6CQC639vXD6n/w/1/4pIHp0PDlfOF0HrqrQcCGrVVnUO0J1pCKRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Cw3HKwyT; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Cw3HKwyT"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-8296d553142so3949453b3a.3
        for <sched-ext@lists.linux.dev>; Wed, 15 Apr 2026 23:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776322045; x=1776926845; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WkIIpMAmcHQJulpNAice5ViX3zPwzM+wnIDyMWYX4lE=;
        b=Cw3HKwyTym6r1cA1Z6l9Ap+AJyC0GO69bbtL+MibqpzzjMbqVHXQRAIb5emTsMPu+M
         JsGyzwOlR5g2FOjlhZlpX+eXmBgv//+LxsjM4Z+6n0QuGJBkwEqcFHTMVFnPiZG+Vy/2
         CJdXtyXW4QJESyrUwxPqLP5lF4trepyPd/yfpfQrMLOluQRb/sVm7VBYwrKSF1BjX6AL
         CARvjY0vkdzhO6PoE4eYNqWid/QdFnl6fyxGdzQwrSfCGgr9BUYpZgEbV8gD2dRYClKL
         7YAnk36khCHxPja9oW0QaTWZ7or4v8ZmuI0vOHt6p0YYlimaTwdNf22ZjwCeKc3Avn1P
         ks2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776322045; x=1776926845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WkIIpMAmcHQJulpNAice5ViX3zPwzM+wnIDyMWYX4lE=;
        b=QxKwJupEd1icrEb0c80qn376ZhsNVRku9sBXzercPdczlip0nGM7I0XaHWAkflXhzT
         OV+fmR8sLXZT/VkEkoCpklkHdY/BYOqrAgpxYRJTuHhTDUrFtw6aRi7uUHeJvJtzEtSF
         9Ud6qJDdDTpnBoFMHKEqAcVAYDcC+ltRwQlGfUw8lUbzLFm8PK3Tmbj8v01FApGnJzEh
         4dMQLa56tbPGyDTsu8px0zoQ31OZuu5nGVTPoKUDRHA3JGXR1H3mFLN1GZGQDKrZEJq+
         xLq1E30cvy5J8eXwbkvKLUv+KRrpNyg7XG/OOVWAXbFpEYl1g/OU8C1pQwqanRghm6HU
         2Ajw==
X-Gm-Message-State: AOJu0YwLAXpEGQTaOeWfKPu9uvFhXMmtG4sZuYykDF/cOjomR2bFoikS
	my36zGJ/AmHOWJnXwRg+QD6zmp+++W59HtHdmEyqb6pVSpCmIcJZ4jlVPC1M9emo
X-Gm-Gg: AeBDiev4e5zndpx78QeeLAgvygKXbyZNA6HjArr50YEU6gvvitJdPCVGcEZcr5I1yGa
	NRw7UyYUWAdi7+7zvl7OHdaSPZcNoC8EFpdB2FgF9QmCQ9G8B/iB3jz4S1mWJlKjNDNivTun8YP
	Ca/L+MgH5vv5pjhF/56kCR+QWx67WfrpZTkqIM++VkQq+iQo/bdci9LLWdRkYbssIuHSL15AXgY
	PX+ckGjoMsfEODrCHR0Ak9eNtjYe29dfY8Ar2y2eLGzMxWCf174G0r53BNwAe9HU59cwqFjBv/8
	BchI2aouRua0gyNNFQhcYB3IBiIAD5ecgdn1oXRLW2whwP8zCjvzOnrzr7Y7Dvj9L9T3osB8Awm
	EF4Lu0FVQKfYP7n2Cye2sCvKSH+KE9rWyULstM1CWyI3/urPK7Ta5gOtsfWhJCcmMjOixbe+Nj8
	222o4CedMjZbHGXVB9DPjIFTITlFiJh8wUwlckRoA8Nu2z2A2W6VcRGC7hpKiF
X-Received: by 2002:a05:6a00:94f5:b0:82f:44dc:f85c with SMTP id d2e1a72fcca58-82f44dcfb5dmr14201969b3a.34.1776322044799;
        Wed, 15 Apr 2026 23:47:24 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:49:cbd5:ab58:206c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6d922a38sm3212392b3a.7.2026.04.15.23.47.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Apr 2026 23:47:24 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	yphbchou0911@gmail.com
Subject: [PATCH sched_ext/for-7.1-fixes 0/2] sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
Date: Thu, 16 Apr 2026 14:46:39 +0800
Message-ID: <20260416064715.1008437-1-yphbchou0911@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

As discussed in [1], scx_kfunc_context_filter() currently allows non-SCX
struct_ops programs (e.g. tcp_congestion_ops) to call SCX kfuncs that are
only meaningful inside an SCX scheduler. This is wrong for two reasons.

First, it is semantically incorrect: a TCP congestion control program
has no business calling SCX kfuncs such as scx_bpf_kick_cpu().

Second, with CONFIG_EXT_SUB_SCHED=y, kfuncs like scx_bpf_kick_cpu()
call scx_prog_sched(aux), which retrieves the struct_ops kdata via
bpf_prog_get_assoc_struct_ops() and casts it to struct sched_ext_ops *
before reading ops->priv.  For a non-SCX struct_ops program the kdata
is far smaller than sched_ext_ops, turning the read into an
out-of-bounds access (confirmed with KASAN).

Patch 1 extends scx_kfunc_context_filter() to also cover
scx_kfunc_set_any and denies all context-sensitive kfuncs to any
struct_ops program that is not the SCX struct_ops.

Patch 2 adds a selftest that loads a TCP congestion control program
calling scx_bpf_kick_cpu() and verifies the BPF verifier rejects it.

[1] https://lore.kernel.org/r/f2ab3yg5niso6hxqe7sd4jmv5xzdizk3khcspm5bylfbn3mj44@tpyiezvs4cod/

Thanks,
Cheng-Yang

---
Cheng-Yang Chou (2):
  sched_ext: Deny SCX kfuncs to non-SCX struct_ops programs
  selftests/sched_ext: Add non_scx_kfunc_deny test

 kernel/sched/ext.c                            | 25 +++++-----
 tools/testing/selftests/sched_ext/Makefile    |  1 +
 .../sched_ext/non_scx_kfunc_deny.bpf.c        | 44 +++++++++++++++++
 .../selftests/sched_ext/non_scx_kfunc_deny.c  | 47 +++++++++++++++++++
 4 files changed, 106 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.bpf.c
 create mode 100644 tools/testing/selftests/sched_ext/non_scx_kfunc_deny.c

-- 
2.48.1

