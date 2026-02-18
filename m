Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD518343D7B;
	Wed, 18 Feb 2026 17:06:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771434381; cv=none; b=OPtm0KdzLQ9EDiwfr4KxhSRlr41IFELR2x74O2afi9Sd9DexIZoHVr+k12j9ARdYiVaqvMxXwJZ13IjHkapQ2lBArhaOMQb+OdMfnFufwuSsREd0Thc2vNCYvXqftKijbet3MXZ0nM9KaT5inhfPqiydEGsY30YzQXVAYblX9pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771434381; c=relaxed/simple;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=EqjjiNLbkeE7tK5GWTRK9edTNqlfk67NRvHWnd9Z26qKONHwZ7iU27XdgXKWeFLdW76uhcAMARKo4QexfcDGtrK2TuyydyMYGw3mn28o4olw569Npv7VUKZE+Lj+jKTTt5dbgkWX1sMF7PcD9ySDN5+Jy7uq+bJzDVjKSZtaWHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UKa3SVMT; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UKa3SVMT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48C63C116D0;
	Wed, 18 Feb 2026 17:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771434381;
	bh=5/Jg/cpVR7WaUS8y+4lvIsX6pu4+Qt9Jv+1IUK5YwJ4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=UKa3SVMTGVhhVpxShTk5J/QddKJyfNLYC2FN9ckCVPN5L1GGAroWnFh9Cc9txm7Y7
	 C50eodPfWT1vsO/P5zCbPosWyCSGALuI8FBoV745Pz5X8Quc89FfXIybph6bOBbOGe
	 Rn+6VwovBhCqZIYDW+Oa+Jg3zfZV1XdwAhIRXVa5P4SWca8pACrFp7H5mGza6s8X3r
	 xmQaWBb6KRN6nBTT5kbuXUOL4MAmGDa9mD9WFfFr9gPtypkZKLH2YOTx6GabcxZkfw
	 2KffR4Ev60XEIKwO9AmS0HMQTtlw+0mDDRN/q5SDcCamyAHlt9jkAU+MUK4WrOdfTr
	 RquqIS+RNKCkA==
Date: Wed, 18 Feb 2026 07:06:20 -1000
Message-ID: <308d7246cc92e95a8c34876d08688790@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Carlier <devnexen@gmail.com>
Cc: David Vernet <void@manifault.com>,
 linux-kernel@vger.kernel.org,
 sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] tools/sched_ext: scx_pair: fix stride == 0 crash on
 single-CPU systems
In-Reply-To: <20260217200836.89785-1-devnexen@gmail.com>
References: <20260217200836.89785-1-devnexen@gmail.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.0-fixes.

Thanks.
--
tejun
