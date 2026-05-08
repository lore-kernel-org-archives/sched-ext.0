Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61782F99BD;
	Fri,  8 May 2026 16:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778256412; cv=none; b=pUeYEm6Y+3CnQarSk+MKm0D4qLLT3Aia6VKvKRK6Mfw9KCF1RvU8un2/8dl02JqwukUquvgVJw2jCx3kWL0UUAG+Mp9uuzhOwxy7CEQ7ypEaDNbgYUKGAra8ByMbV2RlfRKP6vaCFpB+whvPlTWOXzgeqLyYC3/pCzIJyfAiR68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778256412; c=relaxed/simple;
	bh=OOsM8AZJ2WC14Ssz8m/EyGBA2tTB3UQ8s1eIiLawlBo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BoKQsr8p5hQpTK9KKqD+E5z3XM0/EEzOpUHBD9Kg16WxS+sVwiJouWUjEbtTVMgCGRArh6Joyw5++ezFI2mO1Eq/s8jYGBHPia3e9HQIlhgRJ5LI2likuwY24E/AQLmDSV/y37PnqzJd5TxCu+OUVmQ9gfjSrCKZfqgnbRbs3pg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjKUtd/4; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjKUtd/4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56C06C2BCB0;
	Fri,  8 May 2026 16:06:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778256412;
	bh=OOsM8AZJ2WC14Ssz8m/EyGBA2tTB3UQ8s1eIiLawlBo=;
	h=From:To:Cc:Subject:Date:From;
	b=RjKUtd/4tyf5wArx5/VKfPZnKYB0EAwt0y0ayV4jMHtcoy8ASDJAfJD/Ld6C31bsS
	 kuGPcUFwFc7W3W82b4/7iDaEfesPwvOXS/dPDmmC6bHbaIi0f4qLTE1F/VC656D2hb
	 OS4IboSpEMnGsej36Rkd3py5B1a7/E3OoB6q3uIh2KrANuCHXdE0ijRz4QPy42XTSz
	 C24zhV9Ve8xMOXBReEWonqAjcvilRtgKoPt3r0a+Ga25mSHOQnUVtrPX6SBMSYZ5lX
	 Gh4XZJsK8ZtHgZ5ZcegdY4tN2UJ4n31NyiUJVnkcwCbl51vG/AMKatOb/AxaTg86dG
	 v129SRSzsrq3Q==
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev
Cc: Tejun Heo <tj@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	kernel test robot <lkp@intel.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH RESEND sched_ext/for-7.2] sched_ext: Use offsetofend on both sides of the ops_cid layout assert
Date: Fri,  8 May 2026 06:06:51 -1000
Message-ID: <20260508160651.4030241-1-tj@kernel.org>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sizeof() includes trailing struct pad, offsetofend() doesn't. On
32-bit PPC, sched_ext_ops_cid tail-pads 4 bytes past @priv and the
assert trips. Use offsetofend() on both sides.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202605081637.DbH4SZ1E-lkp@intel.com/
Fixes: 7e655ed7b953 ("sched_ext: Add bpf_sched_ext_ops_cid struct_ops type")
Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/ext.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 7ac7d10a41be..f86ee15be7cb 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -10380,9 +10380,11 @@ static int __init scx_init(void)
 	/*
 	 * cid-form must end exactly at @priv - validate_ops() skips
 	 * cpu_acquire/cpu_release for cid-form because reading those fields
-	 * past the BPF allocation would be UB.
+	 * past the BPF allocation would be UB. offsetofend() on both sides
+	 * instead of sizeof() on sched_ext_ops_cid to sidestep trailing
+	 * struct padding (e.g. 32-bit PPC tail-pads ops_cid past @priv).
 	 */
-	BUILD_BUG_ON(sizeof(struct sched_ext_ops_cid) !=
+	BUILD_BUG_ON(offsetofend(struct sched_ext_ops_cid, priv) !=
 		     offsetofend(struct sched_ext_ops, priv));
 #undef CID_OFFSET_MATCH
 
-- 
2.54.0

