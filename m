Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBFB347FE1;
	Sat, 21 Mar 2026 18:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774118536; cv=none; b=c4KIFf/4D06jKcGOgMy+WFHE8jKiJqmcImv4/XaBtLbrWJV2p8CDly/imcpSBsFk5v/OSm3m1wZK4oQAhznyl4SvWTEotDBeFZkBW0KdsYV8gRSx05x44gb9xwbISTnTc6a5aaQla2yqkg8zXz+P7//mxexYZ+XnRCeEEeqw3Kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774118536; c=relaxed/simple;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=dcGfZ7FH2gGpjUg0e/+HDn3DuuyN5MbodCriRtcFFUE2xwwV4VJHwShK2r6TdRbLxYB4Hbs+JKZapGVSS5XdId9sNehT5RFXWkXyY4MCsyx24ISkFOCR1ZdO+sEha5mElKdJ0Kn483Q8FUeAlt78s++kAV3tI6nVhwMs+jLZXHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dgIz94Dj; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dgIz94Dj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AADC19421;
	Sat, 21 Mar 2026 18:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774118536;
	bh=o9U4kP9BoiNmczBWmGX/rTwZTTh7SYM3gh/9l0lKK5A=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=dgIz94Dj4iAfJC93IaAalWi+N5c32krSgW7WRIM7zxADv8Boojr/+5tUZxNTrdndj
	 SqrzHAEeXGB1679251LBCsH/e2PdsfrWzY68Wo2ATTpHyI1IcpRQzcBI+3l5OlIxjc
	 tDmtUp5Iayjnt2xkJSAfjLVpxHqF5m1hyNwvQxPMU16SpG8Y78NSgGH39FNc6UkvMv
	 bcCK2tJpwEpjGZl/EU5rYKfIfmd9sX0xecRhPyvhAB/K0SpOtYSypYw+g0uUO09zdr
	 Yg/xWe6WIQz5EZLrHRbFiKG/kNftHcFAJ1wRRDmf+OMb+gyRNYh8osN80uGh+IxKBU
	 Zvek5ycel3CyA==
Date: Sat, 21 Mar 2026 08:42:15 -1000
Message-ID: <3ec2560124cd05b2ee348b2ca82a8997@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>,
 David Vernet <void@manifault.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Daniel Jordan <daniel.m.jordan@oracle.com>,
 Emil Tsalapatis <emil@etsalapatis.com>,
 Daniel Hodges <hodgesd@meta.com>,
 sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 Cheng-Yang Chou <yphbchou0911@gmail.com>
Subject: Re: [PATCH v2 sched_ext/for-7.1] sched_ext: idle: Prioritize idle
 SMT sibling
In-Reply-To: <20260320172831.365031-1-arighi@nvidia.com>
References: <20260320172831.365031-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied to sched_ext/for-7.1.

Thanks.

--
tejun
