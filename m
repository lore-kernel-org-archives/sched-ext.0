Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32F8134A795;
	Thu,  2 Apr 2026 19:28:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775158113; cv=none; b=uLdVUnTbvlonRmaioOXilT7+A2O11T2pSbWVsQtYxpblP3H7NcG9NA0hkSLfS6g+yMu3kuaIBGKfrzijS2NNj5bnclSNnIAr8KASfx2Ycwx+9RtiVzCWT6Oc4Pc1XoVggx5oCxGPBNDqxRoasijoo9ZAerMzS6KOz3L4da7Du2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775158113; c=relaxed/simple;
	bh=/eGplUhPUZo29frQGkeiSP/VgYWnV6hHXiYPyp1OT68=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=am4tLsp1RMv5eymYklU2MgAyGtlFR6E8w/1uu6dFnzTH8FGJ1GDlXqthS0JEezK+u1M3Yus7rErRXVnhT5yIWZL/3o0aQjmfS2DcyabKD560jA7wo3jhuFsh+z9JaWItoi5y42tAG+j6LiyriByXfFUY3r9X8sleNIvLMfKSvjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QUNinGm2; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QUNinGm2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEC0AC116C6;
	Thu,  2 Apr 2026 19:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775158112;
	bh=/eGplUhPUZo29frQGkeiSP/VgYWnV6hHXiYPyp1OT68=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QUNinGm2ok3/jWS5DU+jmMaf9CVGdCdgfCyyeAK0QtihP6bfvia1yosab9mYWmvxr
	 47m58+YYJGjQedwFtGaslBfKuDKKS9NriFFRL4nlHlXWZmvsNdSUnLByjjf5eLOBE/
	 92qgjgV8Gm6dF9A34OYvWsz3FAJc0mM8y5o0sV1hDVxnyhTMz+rO7anFGCB9uE2ri/
	 oFccWrF7KHGgAhqsNAUoIwir589A6zMvpd/DlrTD2/fladnvmYnR8Mzxb88DKcoNEO
	 vjOrkE2+kwGyqc8QGMnyBb1/duGvq53kGVupveHyvFe0s0BLM1PoTzzDPO/n9iOnlV
	 ALQz90MPKyjtA==
Date: Thu, 02 Apr 2026 09:28:31 -1000
Message-ID: <c7818bd96cbdd6a6c2c98f8dc62e526a@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Changwoo Min <changwoo@igalia.com>,
 Andrea Righi <arighi@nvidia.com>, void@manifault.com,
 Kuba Piecuch <jpiecuch@google.com>
Cc: kernel-dev@igalia.com, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix is_bpf_migration_disabled() false
 negative on non-PREEMPT_RCU
In-Reply-To: <20260402023150.660967-1-changwoo@igalia.com>
References: <20260402023150.660967-1-changwoo@igalia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.0-fixes with Andrea's Reviewed-by and Fixes/Cc-stable
tags added per Andrea's suggestion.

Kuba, I'm not sure the suggested alternative is necessarily better. We can
revisit later if needed.

Thanks.

--
tejun
