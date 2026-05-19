Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07A7D3DEFE3;
	Tue, 19 May 2026 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779177520; cv=none; b=MzP32t9H6XyavaerEL0n2U62JvoiuJSYPAys7gqoZyVqyo7bIArzaAC7PYerjvE3/lbJf1ttoMdXR0sI6B1nLpsCpif24M1GTaJSiZX3rHFNa+u5zOLouJk9j7fUz9vM4Z6xzuI30KYd5wzxn6zlAqKhEEv7OrRv7iO5PxtNt0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779177520; c=relaxed/simple;
	bh=qpUVfrNNPzmLtFUO0UlpaKbsPAr3GEhyHksLuOuuZvI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drmihCD3tM7GTxZ0mlgLD8H2a85yI6RiAm/KHGxtZcw5ejmpR5PS4FE8sKTiJxM0+otAsmAAa3rjq9kY20W7HoiBXTGXT/PagIyx+LFwQV1pT6ZnGFxxrQ1JWn3p8FN5FNEbv4Not7SQIRD1ISn+0YzvIXslvWWlDsmfJOcUDIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CKBdyr+7; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CKBdyr+7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89BE9C2BCC9;
	Tue, 19 May 2026 07:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1779177519;
	bh=qpUVfrNNPzmLtFUO0UlpaKbsPAr3GEhyHksLuOuuZvI=;
	h=From:To:Cc:Subject:Date:From;
	b=CKBdyr+7kZjoS8EdFpZlG6gEFkg/gPZpAt/JKPtaiS0tfCPFkMrtsyTjY0uoX3/OM
	 OSetAmXeC9wC1pNunSrPRWYcxmsmGVkar9uYI+P20X6PVKbPEseRnH2mO72MwdAl6Q
	 ns7EOUr+7/2ViJx6j9BFtmb6bYiWnB/W929zPU+tnap2GXAV/rS43uW7e0ujVm1Wa+
	 6dM4ybnwGbMnVOuCvN7Au6vlVh/pFMu2LHOBVOThypNH7GHvwKBIAPPgzlSbCZQnyy
	 HQaSiBRDoglD9Y/eKJifYpGSL+/leqvKfWcJBQU6pfv17ra829nVBo0oiTdhtjPdsN
	 2vY8CxVRvfoww==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cmask improvements
Date: Mon, 18 May 2026 21:58:35 -1000
Message-ID: <20260519075838.2706712-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

v2 rolls up the per-patch updates that went out in reply to v1 and
includes an update from Andrea's review on 2/3.

v1: https://lore.kernel.org/r/20260517183614.1191534-1-tj@kernel.org

v2:
- 1/3: Also rename nr_bits in cmask_copy_from_kernel().
- 2/3: Init scx_set_cmask_scratch. Bounds-check __cmask_init().
  Widen *_CMASK_NR_WORDS() to u64. (Andrea)
- 3/3: Add scx_cmask_empty().

Three patches for cmask: tidy active-range bookkeeping and add the
mask-on-mask op helpers the sub-sched series will use.

Not backward-compat with the current scx_cmask layout/API, but cmask
landed in for-7.2 and hasn't been released; scx_qmap is the only user.

 0001 - sched_ext: Rename scx_cmask.nr_bits to nr_cids
 0002 - sched_ext: Track bits[] storage size in struct scx_cmask
 0003 - sched_ext: Add cmask mask ops

Based on sched_ext/for-7.2 (1136fb1213d1).

Git tree: git://git.kernel.org/pub/scm/linux/kernel/git/tj/sched_ext.git cmask-prep-v2.3

 kernel/sched/ext_cid.c                | 322 +++++++++++++++++++++++++++++++++-
 kernel/sched/ext_cid.h                |  72 +++++++-
 kernel/sched/ext_types.h              |  68 +++++--
 tools/sched_ext/include/scx/cid.bpf.h | 144 ++++++++++-----
 4 files changed, 545 insertions(+), 61 deletions(-)

Thanks.

--
tejun
