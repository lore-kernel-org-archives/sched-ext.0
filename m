Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B193264F4
	for <sched-ext@lists.linux.dev>; Fri, 13 Mar 2026 01:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773366594; cv=none; b=ibS+C1lyuipBcq6BQLQG6i1sWM8FGW04tDwILvjBCnmRn9zWy9Ica3bAbw4w0d39VtCXj22RSOTKlGSYc9kh2uePbWWeBt99/PVWvJeDRiCP8ZiAE46GWdOOJQMv03AMkEs2WOmuVkT5QqiiGVUcHq/+dG5kl1CEEW53EUSJkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773366594; c=relaxed/simple;
	bh=HcCYrUbwdbQ9qm+SnnxDstNfQalstmwwMj021hOE+0w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=D50qyY3BdOql7Yzir4JoAN/R3THVNL78emCmnhQ4LUnyCG8gS2gUlTyPhq8Y/EYcJfsVeouiP3C28AlWok0JQxtB+Jpac3Lg60if/mdro1NcjrOJTKRKJswlXNs92TV+FJasFbV3mk8399OCPs5ENd+D7HqGpRSQJBUz/2q+2xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TByNGTR1; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TByNGTR1"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-829ac4670c4so1246258b3a.0
        for <sched-ext@lists.linux.dev>; Thu, 12 Mar 2026 18:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773366592; x=1773971392; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xyLz6TfxBag2GcRlSGPMEMKECM2OC8P+AKQN/bDhyRs=;
        b=TByNGTR112Y+Dwda8va5/Nl3gekPRXy5h79pffBRgYRcYOg39K8LimCq0R513Px4+z
         BtNIJ3xGbDXTF0Fmhx7FUtU2p/RbdMhUfqgFv+uhM7M+zszWhCRVZNqem4K3B59juziN
         rVe1MuFH2fN9aGf4iAaKy/MX7s7Sdknn5xt6S3//6dYs/BBfCLGLsQOLQ4mtktmIwxEZ
         Hssf97PsAMi32RxmrQ+Zl+R+ImObfaQb7OXKcbrKQPTrJXwIPKC+GwGCwfMAV6gv8GKl
         JejfXbOHXs6gDIWJOP3UxmtW2zp1zflQxn3B8wneucANS02MUwtijejKfUUwPJo1xMwc
         Cj+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773366592; x=1773971392;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xyLz6TfxBag2GcRlSGPMEMKECM2OC8P+AKQN/bDhyRs=;
        b=k+QkKn51C6djX4oMjvmkMoW0iYgXBy4/qKQzsPlEGnJIu2ycmH6EbechsK2DrrzU+y
         hrmCSRNRmwa1rjhBiN/MhONyZxtWBPKsGOqwrC+KAJ+ND8k332hNuLGS6B5fABbwXkJP
         UOucS/mBDx4HmWfGbvhbUN/k+mHEonVFgGQywcCNWxH4o8mzBCDo46t+trJitvKkvCI1
         tGGbGVsqvXA8CFeF/3lzdhQMGFJa2FuQOym4zG7nLGwGx5JWIc5hTFARdRf8ETEFtrnK
         lRLM9hDly7KQg8a2KU9bjGsVkWkIsJpLtjZE0rU2wVaHGQOF+y5wbRy6/OHetqAUMZBl
         m4FQ==
X-Gm-Message-State: AOJu0Yw+KWpPXq4QAZ1JbgpXfOEbNzE7dm22toqKn6UpQpnJrP3tMhwS
	AQbi3J6xEYgNQLwrWREx+yTiEpDtIN5wqBnNaS2qCv4t2JxhDv6Bwi2bOHi+PF8M
X-Gm-Gg: ATEYQzzP7dseOZm1z52Xwxn1BEftc7peWbCqj3QTkdAUgj/jWg0zT2t5on9hMJkTDIZ
	n0ckKzz2HBCQ9MbnPhkXfQ6pcVZWnHbm6WvcLlG35AZlFoppdbWexm9Zz53++j08kwMjXFsg/xZ
	X5xz2qcf8CsOZQ0VFG0NWmvZZEX6c/lSlp0D+L4fGA38QHE+tjm/ei37LVuB314Fe2a2WqK6Gno
	ixyTAp4VY9MCY4XO19PEf91Am8yEncx/dYAvFYxkELI7e/n7zv38rqfshFJ0S2xnAp8qpFN3Ank
	edMg6Q97fSydRWGZPYNo3nSltzGruRnbLdoh5o0APvQFLkwokLlEy1HFCmhB7c8DW+g5k0mNOSy
	1JA/iabIHY/FsP0qblPEx2+E975DmnZHizdHT95HdT2Ewy3oWSlA7gUUIRwDZZgwxmcTswuU7dy
	FuH3oFFN/BYS9K/QAQizjgBBS1TnhbiyoHcXgdkyJmg/H07gjIJIEY
X-Received: by 2002:a05:6a00:bb84:b0:82a:8aa:cbb0 with SMTP id d2e1a72fcca58-82a19733b85mr1222594b3a.29.1773366591868;
        Thu, 12 Mar 2026 18:49:51 -0700 (PDT)
Received: from eric-wcnlab.tail151456.ts.net ([2001:288:7001:1099:d94d:d676:4576:a8c4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82a07365090sm4268676b3a.46.2026.03.12.18.49.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Mar 2026 18:49:51 -0700 (PDT)
From: Cheng-Yang Chou <yphbchou0911@gmail.com>
To: sched-ext@lists.linux.dev
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	jserv@ccns.ncku.edu.tw,
	yphbchou0911@gmail.com
Subject: [PATCH v3 0/2] sched_ext: Update demo schedulers and selftests for deprecated APIs
Date: Fri, 13 Mar 2026 09:49:42 +0800
Message-ID: <20260313014944.1234667-1-yphbchou0911@gmail.com>
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
  sched_switch tracepoint, as introduced by commit a3f5d4822253
  ("sched_ext: Allow scx_bpf_reenqueue_local() to be called from
  anywhere")

This series updates the demo schedulers (scx_simple, scx_flatcg,
scx_qmap) and selftests (select_cpu_vtime, maximal) to use the new
APIs, keeping them in sync with current best practices.

Patch 1 updates scx_simple, scx_flatcg, and select_cpu_vtime to use
scx_bpf_task_set_dsq_vtime() with scale_by_task_weight_inverse().

Patch 2 removes the cpu_acquire/release stubs and the
__COMPAT_scx_bpf_reenqueue_local_from_anywhere() compat guard from
scx_qmap, unconditionally relying on the sched_switch TP. The maximal
selftest and reload_loop test are also fixed to properly attach the
sched_switch tracepoint via bpf_map__set_autoattach() and
maximal__attach(), as both tests use the maximal skeleton.

Changes in v3:
- Use scale_by_task_weight_inverse() instead of scale_by_task_weight()
  (Andrea Righi)
- Link to v2:
  https://lore.kernel.org/all/20260312175527.1220540-1-yphbchou0911@gmail.com/

Changes in v2:
- Use scx_bpf_task_set_dsq_vtime() with scale_by_task_weight instead
  of direct assignment and remove redundant bpf_ksym_exists() logic
  (Andrea Righi)
- Mention commit a3f5d4822253 ("sched_ext: Allow
  scx_bpf_reenqueue_local() to be called from anywhere") in the commit
  message to clarify why ops.cpu_acquire/release() are being deprecated
  (Andrea Righi)
- Fix maximal.c and reload_loop.c to actually attach the sched_switch
  tracepoint by calling bpf_map__set_autoattach() and maximal__attach()
  (Andrea Righi)
- Link to v1:
  https://lore.kernel.org/all/20260312042001.955675-1-yphbchou0911@gmail.com/

Thanks,
Cheng-Yang

---

Cheng-Yang Chou (2):
  sched_ext: Update demo schedulers and selftests to use
    scx_bpf_task_set_dsq_vtime()
  sched_ext: Update demo schedulers and selftests to drop
    ops.cpu_acquire/release()

 tools/sched_ext/scx_flatcg.bpf.c                  |  9 +++++----
 tools/sched_ext/scx_qmap.bpf.c                    | 15 ++-------------
 tools/sched_ext/scx_simple.bpf.c                  |  6 ++++--
 tools/testing/selftests/sched_ext/maximal.bpf.c   | 15 ++++++---------
 tools/testing/selftests/sched_ext/maximal.c       |  3 +++
 tools/testing/selftests/sched_ext/reload_loop.c   |  3 +++
 .../selftests/sched_ext/select_cpu_vtime.bpf.c    |  7 +++++--
 7 files changed, 28 insertions(+), 30 deletions(-)

-- 
2.48.1

