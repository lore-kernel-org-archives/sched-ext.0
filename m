Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EA6D31AABF;
	Tue, 21 Apr 2026 17:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776792620; cv=none; b=VQ86sDlwfndt6Qf2HB9gHJYm0yH5MovWP+d4UznGLs/4vP4w84g9se0m5cq6WLiIowvLiaj1apZsae465okly66tk8WD46lySYTW2wKYoB/Astc8OQy7bVLCdVDG8axD7kEC2mg+jJOwJjTPKPORGg6vSQ/sKFu9jxLihTyvb0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776792620; c=relaxed/simple;
	bh=iuhSCd5n7cRX6znxD+P0+IEQzyxqo9zHyc/CK7X0Tx8=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=VYCfaPltPrtMU2CTPyn2vnaneKIM2BZqvQuEiles4IG02bxQunzGbqdU+TYAJsRj/R0R665i7kOyYPiMo33bM/WOndAcIaZXuYM1azZpjGSb7K9r1//oK1rs/EwMxpZsvtL7CE/s7+ve/mRCktc6AreBo53dAx/rJyro8p8HCD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o0BJvcZs; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o0BJvcZs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4250C2BCB0;
	Tue, 21 Apr 2026 17:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776792619;
	bh=iuhSCd5n7cRX6znxD+P0+IEQzyxqo9zHyc/CK7X0Tx8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=o0BJvcZsp4dLD+62E9L+GJMTRvpWfJbSwpWVs5JD1Iyms2/T1Iy+N6aHm7s7y84zy
	 GdYoQWdQgcfWRVcLnwIW+lk1z8krVzVGRA+RyG43cCc5ZMNe1a3PEZCzHmaMFDJu8N
	 7doVndkiLrDUVtctJbtTzCFvcusOJKjmo0WqJ8xAU6sd0jEfHe8HoDQF+Q8RGZ+c5/
	 BXIwI3owyNs4csxUTISzqplkCQiTsfiX55e/MpV5NZOwNV3uiX36zbae92Q3mCAfCQ
	 XVHU94LBkEAZKPnsiq1RvQZBciRFYhif5G/DdBuK+5eWP/dbvbvxKYqcy1dvg/BhDl
	 Rnuuoyp97Zp6g==
Date: Tue, 21 Apr 2026 07:30:18 -1000
Message-ID: <6cccef586daa450e322d9659d4e64e13@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>
Cc: sched-ext@lists.linux.dev,
	David Vernet <void@manifault.com>,
	Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>,
	Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
	Chia-Ping Tsai <chia7712@gmail.com>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.2] sched_ext: Refactor
	scx_root_enable_workfn() enablement task migration
In-Reply-To: <20260421074154.584737-1-yphbchou0911@gmail.com>
References: <20260421074154.584737-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Thanks for the patch, but I don't think this makes the code better.
scx_root_enable_workfn() is a linear setup sequence; length comes
from the number of ordered steps, not from doing unrelated things.
Each extracted helper has exactly one caller, so the split is pure
code motion. The locking story and the error path both fragment
across three functions, and small things drift - the TID_TO_TASK
read moved from ops->flags to sch->ops.flags, which is equal today
but sch->ops.flags is mutated elsewhere (SCX_OPS_HAS_CPU_PREEMPT),
so the two sources aren't guaranteed to stay in sync.

Thanks.

--
tejun
