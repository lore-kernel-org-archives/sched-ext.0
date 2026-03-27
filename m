Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9600257845;
	Fri, 27 Mar 2026 17:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774633395; cv=none; b=HNkONTYCdmv8O6Iw38I61N+ECn4L336tjTReGzNWIHfnq1eYZNgsB3vrKenwH2EPqmfUEi/VSso8v04kk2YhVkB3WoR1guQxS+tfF36Gz3zxFNQbRB10NLGkF/liJ9F0XyQTOJRXqlIuEXItPRZA/8lJPhDCZtrNhe6ANrtcdrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774633395; c=relaxed/simple;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=YCGyXA2T/2xQkKvF1MfP9kF7T6hUTceQdvITPAq+jCNiKxKKceJtk+PmlI1xWpYcYu3l2gyWX0XjIwc2ifL3KzRjCHrMLKRyJvWBxMl36aSoxbES5dP91O66/SClx+RONBmX2n5S2iOrr967BPBSKvPUla1Hs6dAsNlYog/jSmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YxSFlV3c; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YxSFlV3c"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62BBFC19423;
	Fri, 27 Mar 2026 17:43:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774633395;
	bh=+0ix+E8GBUCgIN6jbrba74DKgOITHGZNkoqWjOpimuI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=YxSFlV3cvp8vDh2UfCmqo/CSivyZdYFasYBaqx7lr104BPOW8/XqObw4Rv24WFyqL
	 sL9av5aZQKcZashrjFFyKPO0s7NVgFkHeYivFLJxdnF8Omb5QQhv5pf58+wEzIeS4X
	 qBfiL2z7Ky3Xg3dyarVbfekC2P1EQhJOW6p/g5rVKFg5H3vvkgYW99qt0nwQWS7El6
	 mHoPqGea1kDXdqE/yuTKX9npG6nbQMDi2ElTs0aflcv/x5xBqqMTrCKiJlChTILpqg
	 oTGHPwvs+bpC1niDAX0lg3rpxnEVMRvXxnHoLZ8qb4YAnU0PPQzFsrZu2/bHwBxU1V
	 OvVX/cv6ngPcA==
Date: Fri, 27 Mar 2026 07:43:14 -1000
Message-ID: <16a4d23ba7dcadc8c1a1a0a20900a279@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Cheng-Yang Chou <yphbchou0911@gmail.com>, sched-ext@lists.linux.dev,
 David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Ching-Chun Huang <jserv@ccns.ncku.edu.tw>,
 Chia-Ping Tsai <chia7712@gmail.com>, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] sched_ext: Document why built-in DSQs are
 unsupported sources in scx_bpf_dsq_move_to_local()
In-Reply-To: <20260327095125.1149375-1-yphbchou0911@gmail.com>
References: <20260327095125.1149375-1-yphbchou0911@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
