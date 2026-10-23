Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792797664;
	b=SIjUP+ITQW8vx5YEqniZ7kDkBvyO3wPjRQ4DI9rATx0ZDvcf+iUiNfR6HRSULO2/jhG2
	 mxU/GjLbidnyB4WqiTy/M0dQ2Nz+nX8wtKVUwXHHcsftDYxBDuTpWFxPyv+YIpxLME9DS
	 XlLO3RXw0CsQh8LftAD1tWsrDS+1w2JxnkG6JmPk28EX+eOQCTyF0HHpz/pP/y/NG1qyG
	 N0Ubp6yR5sLkNI5lVRUtGFVURUVETb+u0w4clavU4kY5gxInj2BRppYI+jV+MDXB6lrVV
	 wttip2wGFPASo9JorK4oar+MIqBbl+aYFl4IqcexRjO36Q/nN5FOU2TyI3EOUnZ6A/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792797664;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding;
	bh=6yr2FiD65ejmI2ejP0FjPrTrPZ5wMzbdLZS9mjV5Yys=;
	b=XArAb5Cm4ipQYuL4VPijbwf0zaSjs0WDfwkwDRJdAftrjHCSX5xOM4yQgcfdMW4JHryl
	 0FNn53vJnauKi8KeGJ/k8PYKIXIZkuMBl+7vNhp/M7s1kZr8+Ieo4gJ95u1xVBDnb1MOk
	 CnP6N2Qzztr3cS8UX0T5myj9S965xOaGzUTl9kDjk4FPmo/R3BMUPfNcYUG/VGE9ftwHv
	 J2GNazbwukYD5Jqhw8gPD0msH1EjpJL8/z1fSt2ZvTfbP4Y0V6GCPiEKH52qW7n4fPyVX
	 enOgImc1COz7bGjhs0ofq5UjNM4cevWBlSpDQAhtYmAf/GGFxRj/3SGJVdZDfelwppA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeN3JFAq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE34B60A2610;
	Fri, 23 Oct 2026 23:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EeN3JFAq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64F851F01828;
	Fri, 23 Oct 2026 23:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792797663;
	bh=6yr2FiD65ejmI2ejP0FjPrTrPZ5wMzbdLZS9mjV5Yys=;
	h=From:To:Cc:Subject:Date;
	b=EeN3JFAq49UJdwFl5VZ60plcvnp/BVxpxfMhP2duXmw5gAPX472SuTnXiNMeyADY/
	 osV0SXIExVPd7GcteIHfhialhYKMAuWRvMSHiVgLWnWWakiooyNL/ylJuNm4Vo/8Bw
	 yXYatzBhOJ/kInPZxd/rvXRF7ORMHo+nP+eDKKD4OB0C541JjBon2WJp55CI5urKtW
	 CInZoN0aeKu3FbbqOr62OZkd+3GZU+v9sh1T0iXQ1P0RWvBYU66u/k8s5kE7H3nE7L
	 EWYd2ex1/hDzFNriX132rHV97Adb/ESQBIWIAsS3VkC0BZJAfkyAUS0cibstu7y04v
	 bCyfC9NvEU5OQ==
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-7.5] sched_ext: Sync tools headers with scx and fix unsigned enum reads
Date: Fri, 23 Oct 2026 13:20:58 -1000
Message-ID: <20261023232102.1124938-1-tj@kernel.org>
X-Mailer: git-send-email 2.56.0
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

Hello,

This patchset fixes __COMPAT_read_enum() sign-extending unsigned 4-byte
enums, which made SCX_RESCUE_DISABLE read as 0xffffffffffffffff, syncs the
shared headers in tools/sched_ext/include with the scx repo, and drops the
enum lookup table entries for enumerators the kernel no longer has. The scx
side is https://github.com/sched-ext/scx/pull/3930, merged, and
https://github.com/sched-ext/scx/pull/3932.

With both applied, the shared headers in tools/sched_ext/include are
identical to scx's except the two generated tables, enum_defs.autogen.h and
enums_abi.autogen.h, which each side regenerates from its own vmlinux.h.

Based on sched_ext/for-7.5 (dd3b1d9be27c).

This patchset contains the following 4 patches.

 0001 sched_ext: Don't sign-extend unsigned enums in __COMPAT_read_enum()
 0002 sched_ext: Sync tools autogen enum lookup tables from the scx repo
 0003 sched_ext: Sync common and compat headers from the scx repo
 0004 sched_ext: Drop stale entries from the enum lookup tables

The patchset is also available in the following git branch:

 git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git enums-sync

diffstat follows. Thanks.

 tools/sched_ext/include/scx/bpf_arena_common.bpf.h | 23 +++++++++++++++++++++-
 tools/sched_ext/include/scx/common.bpf.h           |  9 +++++++++
 tools/sched_ext/include/scx/compat.bpf.h           | 16 +++++++--------
 tools/sched_ext/include/scx/compat.h               |  6 +++++-
 tools/sched_ext/include/scx/enums.autogen.bpf.h    | 18 +++--------------
 tools/sched_ext/include/scx/enums.autogen.h        |  6 +-----
 tools/sched_ext/scx_flatcg.bpf.c                   |  5 -----
 7 files changed, 48 insertions(+), 35 deletions(-)

--
tejun
