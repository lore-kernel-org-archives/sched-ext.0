Received: from mail-vs1-f46.google.com (mail-vs1-f46.google.com [209.85.217.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4A2857FA
	for <sched-ext@lists.linux.dev>; Thu,  9 Jul 2026 18:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783621701; cv=none; b=b0ClergEtYyOSMuCvmQO7Q98vz7rHMbj1isW6YUBwrxgvpSdmoRSFFUk1Ek9f5JdHLjhh44yVexFbFf4+RNNYDvDqj3bXPmzjagFg9tzYXVW6uEo/ObPK3yCyEx7cYTbIRz4E4BXDqXk7nOqJydSA7P2riaHSNKVvJlkkV/OPzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783621701; c=relaxed/simple;
	bh=50Wjn1H7SmZ4qc2K0sSC2vd4RngDK0mz2nYLLmXWJA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sZLN49+zAU0cz26uH1Nw9LtkQ467UoJ4f6dfsCe6o2pytOZMvFr77hU6qiZRczKLHwOD+6JLjwk5YsNxYA6OMpKTsJBX25m99QB6RIr2BtKL3OmJ/VBivc/gd0n9b0dOch48sylNSf9KbHdCMweUHTDwuJa1fv2RqkQgV3/5HKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NM3gQzlc; arc=none smtp.client-ip=209.85.217.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NM3gQzlc"
Received: by mail-vs1-f46.google.com with SMTP id ada2fe7eead31-73750ce4b2bso69821137.1
        for <sched-ext@lists.linux.dev>; Thu, 09 Jul 2026 11:28:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783621697; x=1784226497; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NfvOR67GhSzSQwd3yk2SQbsKhR6LSWv2OrkrLacBwig=;
        b=NM3gQzlciPSGPUFnh6x+kog76oJV97wabIgnZ4u/4M8osAgmyDl4Zp0YpSOyl4CfTc
         fmg0Be9uM66KL6ojm1liZ5fSDEareg54KuN6WTpWGuriukB6iMBPjOXfsgeDgmbUi1A4
         Aozwl2G3ejU+Mms7bpqKPNX+xYeSu+4AtHLn9aL1WG2FUEzIj9wLCViDKVLkyTWqapjT
         +bu7JcCMT6wnQ/0K5MMOFDX0dBYFtzFh5kpBrzPZ2500J9iBp2yyfwmDZdyz5rlF2rTa
         fq87J2DsUsM9hXgzMl/xNX2crkzM9Qk1c51kG2w5yespnAZszSyMTgS56T7/TW9j0ssX
         qBLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783621697; x=1784226497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NfvOR67GhSzSQwd3yk2SQbsKhR6LSWv2OrkrLacBwig=;
        b=kDlLEP5n7vzEMoU9Wo7OXgZnofBAeOCcHR4KoY62fypbbq4tdHGeHSYBEg80IkuZtI
         N1t6njNNzIDdfW2nQk8rAqRPA/BTwVyzb3gTHbvT0+yjG4GwVP15ZTSwMcHNxmOy/lPc
         8/1PogoejRrtYBQrQe5LgxiwFubiF9D9TjjDZ93h9TryLtZEL6RHmdvr1lN9mLIyN9Qu
         dSio3wW91krojpJainYgsLs/QyP/q0tYfX5gG83VBD3+fEA/nO2hnVVSO89L4jqtaaPV
         dq1GDLLJzEt7dtjwHA9Z+wR1G/g8R6WlC1pPIb48/HH2tg8WnQsNB54lM4SAxeJ2wX3s
         rsyQ==
X-Forwarded-Encrypted: i=1; AHgh+RpUS+4zmxN0IfUH7wS9c2Uj+0hPuaI4ml1Qa6DNCOYekZvBL84wvk6OantksVoYQfZvsVWu7QkEnkM=@lists.linux.dev
X-Gm-Message-State: AOJu0YysxOlWZFFoiMF+EQ5DT70uH01u0cP38q9YT9Btrtu/Hkp3o+p0
	xERH4YS6Lu+1YKeFzJ9YUk1NbICLVH1/Qb0xEoi06kZnhlEjViwO+Vdl
X-Gm-Gg: AfdE7cmzxPIMZycVzpMfCv4i6PkWIH/0OQ2rKA1WV5bM/fJ1DOhoWyDN1giLtVjThx6
	gjhhyODX1wgeyqeXSZlsUp3JCiX+fzSDjTFs6jO3/49zDN+YnFYbs9+fRmJKJjNmbmL8f3doYDP
	m9k1/vxtJ+4OxPPdFWgj/yTvS6X3ygTULViWl6tkvB9W5ewnMZrkZwyZ8/MNv+6I34MGNzvAZAu
	wlzNgdhYlNP7+db9FYJzlaOXuU9CRT051512FXGQBbQO6umv6mrcghqGBcKHCFVOZk2a34K7A+N
	STxNbtfaTMcxev5tSlPEldPxIU0EK1GJ6UrpTFvO1goqnlEfAMyq9FDvHaxCf99Qmbf7spTsF2+
	TypYLO/a7LAeAtPxtfa7J/tI+o9kWp48kiGxzJO4t0x8NWJnYD+iC4GrHdstnEA3D2AY5Q09rW3
	TLJVWP7U0x2z+BG+4T+UY=
X-Received: by 2002:a05:6102:5e96:b0:737:61e9:4116 with SMTP id ada2fe7eead31-744dfed3b3dmr4579404137.22.1783621697194;
        Thu, 09 Jul 2026 11:28:17 -0700 (PDT)
Received: from TurinLinux.. ([184.144.109.221])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-96ed258bb75sm3437743241.1.2026.07.09.11.28.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 11:28:16 -0700 (PDT)
From: Nicholas Dudar <main.kalliope@gmail.com>
To: ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	eddyz87@gmail.com,
	memxor@gmail.com
Cc: tj@kernel.org,
	void@manifault.com,
	arighi@nvidia.com,
	changwoo@igalia.com,
	bpf@vger.kernel.org,
	sched-ext@lists.linux.dev
Subject: [PATCH bpf-next v3 0/2] bpf: require an owned cpumask for bpf_cpumask_populate()
Date: Thu,  9 Jul 2026 14:27:58 -0400
Message-Id: <20260709182800.2037938-1-main.kalliope@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpf_cpumask_populate() writes its destination with bitmap_copy() but
types it as struct cpumask *, so the verifier accepts a borrowed,
read-only cpumask (for example from scx_bpf_get_online_cpumask()) as a
writable destination. Fix it and add a selftest for coverage.

Changelog:
----------
v2 -> v3 (v1/v2 were a private report to security@kernel.org)

 * Split the fix and selftest into separate patches.
 * Target bpf-next instead of bpf.

Nicholas Dudar (2):
  bpf: Require a BPF cpumask for bpf_cpumask_populate()
  selftests/bpf: test bpf_cpumask_populate() rejects a borrowed cpumask

 kernel/bpf/cpumask.c                          |  6 ++---
 tools/sched_ext/include/scx/compat.bpf.h      |  2 +-
 .../selftests/bpf/progs/cpumask_common.h      |  2 +-
 .../selftests/bpf/progs/cpumask_failure.c     | 23 +++++++++++++++++--
 .../selftests/bpf/progs/cpumask_success.c     |  6 ++---
 5 files changed, 29 insertions(+), 10 deletions(-)


base-commit: 36ffa86c42f91c8a57071e024afc4ffb51a8958f
-- 
2.34.1

