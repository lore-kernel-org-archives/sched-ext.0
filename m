Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16C3048B37B;
	Wed, 12 Aug 2026 21:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786569372; cv=none; b=YJidSSijya78YutHg8/Zhb9U2UVwofEGOAvaw287ZUZbh3180yYosy/taJPd+Z+00HghngZwXEneTyE8vEHl2xW69PBUuNP0pXDSoIoOUswYJ5h7TJN4H2kgCP+nW+4pIPiADHKD+inSMcKMfwt/fQnat22RmwpDErXvFXNd06c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786569372; c=relaxed/simple;
	bh=kIiDjeUyuDCDIo8wNx8KlcklbrmyKNxcUVGdsy8DsxA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lp+Q1ibsmindbVYES4Hv6VqYA4wV9aYpV8Sdtqm5wzlkD/PwQ6gqr9F6dZldU8emJpglsyjsii1mQGW3uEqQwc7vfmHZvwAPw6ID1ZGYjnPXkWU/zHOIJDl3USSC4UsM0TcQvQS57oio8kUt7BGp58Xm5jApjLMF5djJYtdLSFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eKAycrNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eKAycrNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819CB1F000E9;
	Wed, 12 Aug 2026 21:16:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786569370;
	bh=RpQhdg/QTxLp/9eazlCeybHpEsxG6eRjpDGXxMBgH/4=;
	h=From:To:Cc:Subject:Date;
	b=eKAycrNj97jCjHNJFyNjUl29iEftsBGq7fFv8UFpgDmvxf/BJr1iSQkbK1AukXMrn
	 envM7CxEW3kyz7D9LnWggB6AyMp5qB6SlJIYc+1nAhfpHfwV3kv4k/DSNMeZnGtmln
	 +fc2t/lusZ35+HcVWYgzM0q06ph5GmqyhyXEj6BJkBrGOWOw9SX3mmH+URUkiZG/GW
	 tswO2dEDSwBDEtkogUYg34s6Gohezny0KPcsRIYhcpEZUtChGzdZWoZ2O0JKyjePVz
	 rJ4l3oValiRpUqtEtHFBMJAyPm3LnZwlXEB8Mv2Tj1jXKQKBFljTSVI7kXELOJAjaD
	 A8nZ8S1sBiHoA==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCHSET sched_ext/for-7.3-arena-args] sched_ext: Convert arena-pointer interfaces to __arena arguments
Date: Wed, 12 Aug 2026 11:16:06 -1000
Message-ID: <20260812211609.2495583-1-tj@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cid-form schedulers keep their data in the BPF arena, but the interfaces
that pass arena objects between the kernel and BPF predate the __arena
argument support that just landed in bpf-next: kfuncs took the pointers as
__ign scalars or verifier-checked buffers, and both sides rebased between
the address forms by hand.

Convert all of them to __arena arguments before cid-form schedulers start
seeing real use. The ops_cid set_cmask() and sub_caps_updated() callbacks
pass kernel arena addresses that the struct_ops trampoline converts, the
sub-cap kfuncs and scx_bpf_cid_override() receive rebased kernel pointers
directly, and the hand-rolled conversion helpers are removed. The BPF-side
declarations carry __arena-qualified pointers, so scx_qmap passes its arena
objects without casts.

The arena argument address translation is currently implemented only on
x86-64. cid-form schedulers using these interfaces load only there for now.

This patchset contains the following three patches:

 0001-sched_ext-Pass-kernel-arena-pointers-to-ops_cid-call.patch
 0002-sched_ext-Convert-sub-cap-kfuncs-to-__arena-cmask-ar.patch
 0003-sched_ext-Convert-scx_bpf_cid_override-to-__arena-ar.patch

and is based on sched_ext/for-7.3-arena-args (294d95ff251b), which is
for-7.3 with bpf-next d114bb989367 ("Merge branch
'add-arena-argument-support-to-kfuncs-and-struct_ops'") pulled in for the
__arena argument support. The patches are also available in the following
git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git arena-args

diffstat follows.

 kernel/sched/ext/arena.c                 |  3 +-
 kernel/sched/ext/cid.c                   | 60 +++++++++++++++-------------
 kernel/sched/ext/ext.c                   | 22 +++++------
 kernel/sched/ext/internal.h              | 19 ++-------
 kernel/sched/ext/sub.c                   | 53 ++++++++++++-------------
 kernel/sched/ext/types.h                 |  6 +--
 tools/sched_ext/include/scx/common.bpf.h | 11 +++---
 tools/sched_ext/include/scx/compat.bpf.h | 14 ++++---
 tools/sched_ext/scx_qmap.bpf.c           | 36 ++++++-----------
 tools/sched_ext/scx_qmap.c               | 68 +++++++++++++++++++-------------
 tools/sched_ext/scx_qmap.h               |  4 ++
 11 files changed, 148 insertions(+), 148 deletions(-)

--
tejun
