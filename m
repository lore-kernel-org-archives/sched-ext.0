Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91230173;
	Thu, 11 Dec 2025 22:48:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765493291; cv=none; b=Ewmkh7YfG/OYhEBIEIQIna/+EnOPuxu9cuCcIg1yaDfn0WCCzbDzbj4t+W2rPDMF1nMKokS12mpJInGA8EvuQ65xmXIUDeH1Y/50irlSRzS7Jlsk691H4qCLPgKYyeTYhobpVcWy+YqX6rHSNa7LSjHXacQU+8LUMOquidBbSZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765493291; c=relaxed/simple;
	bh=n1Zsol2d+/ExJuLPhBabWaN2RrF0E39ruLFZHD3YEBc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cGDoCXjtQz5jPsNAriRRlTo+CdD6cOB01F6kX/dngcxa6PRtbxUQJXqGzLGX9dnAmL0t3y8fIIfUmaFLvuIl86vfKFOfu6k/WP4BgPHDaxY2yslh1diAR1qQphiWKfc9x9JJt94oHzJIq2L1AsdAYH3cYe8YDgAmN1jYDkBrpGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ckjBOjS5; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ckjBOjS5"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF60AC4CEF7;
	Thu, 11 Dec 2025 22:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765493291;
	bh=n1Zsol2d+/ExJuLPhBabWaN2RrF0E39ruLFZHD3YEBc=;
	h=From:To:Cc:Subject:Date:From;
	b=ckjBOjS5cpFHi3rLRJTfc7ZFQtKeU1e+dO06Z1OU+icrCuT+fftBY249zhNDNOuC2
	 omAqaHrQ4Tt0nR46MyxXQQUbwMeUHoyf7Hv986NNDmJb9E92fitr/ruIamfVDX1elc
	 fn9dabAsZ8vPuxQeDLJTdKMX5b/HiKhobQmyAPOVcTBW/2nJjk0qq7qrr55rS98Dc2
	 KG4z6I5Dh+VxAiPrYJn12KFmXQzeVMv53llsAAAbGhXgS8GJrzGj2JKe2t+BxE7PyT
	 fFE5ufzJnmA9VvUUbdVUxgmczcOF3QP+pKq0sGCyBAHv91UHbF0YjY5buasW4Eg2Ju
	 CxQY7gNnmb+kQ==
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	David Vernet <void@manifault.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org,
	sched-ext@lists.linux.dev,
	Tejun Heo <tj@kernel.org>
Subject: [PATCHSET sched_ext/for-6.19-fixes] sched_ext: Fix missing post-enqueue handling in move_local_task_to_local_dsq()
Date: Thu, 11 Dec 2025 12:48:07 -1000
Message-ID: <20251211224809.3383633-1-tj@kernel.org>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

move_local_task_to_local_dsq() was missing post-enqueue handling which
matters now that scx_bpf_dsq_move() can be called while the CPU is busy.

 0001-sched_ext-Factor-out-local_dsq_post_enq-from-dispatc.patch
 0002-sched_ext-Fix-missing-post-enqueue-handling-in-move_.patch

diffstat:
 kernel/sched/ext.c | 44 +++++++++++++++++++++++++++++---------------
 1 file changed, 29 insertions(+), 15 deletions(-)

--
tejun
