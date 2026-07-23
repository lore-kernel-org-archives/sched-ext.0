Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E74B5360EF4;
	Thu, 23 Jul 2026 18:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784829945; cv=none; b=Y5plHV2tPmaXrJUwlZqOB0UTQ/IUesSYGhI1gYRXQxo1tHfxG2uCW3VE3QO4stZqgbbvMVTs3xUZQeJ6rs6F3r+xOVFyfQPbTGVOOTNBnbIuDuks8G/UFRtrNRnsxsuhHC0itaNhRtVcArMOSnmdrzm7k5X6YzRe8Xu/zqjdT4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784829945; c=relaxed/simple;
	bh=i7ZMRy/Mzc6Q/pJAHL9QsOwSqqjUlZ48fxf9SOC0ehc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=lPXlZf891YwK7qx5+QS9rqMsMXZvxEPJ0pegm81GtWFd1Goecqp4XQous6O+rJxLXwnEyuv9KnfHXm3W6ByWBhgyEHkVbQrpsfOqnFhl6cVLtTbxSSk+WS4jC6Au3kFmoDta7XykvxsGEHEtY6Hgh3ttJKs72NGDwQ10YPSKSdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z3W5Bcdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z3W5Bcdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C3861F00A3A;
	Thu, 23 Jul 2026 18:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784829944;
	bh=i7ZMRy/Mzc6Q/pJAHL9QsOwSqqjUlZ48fxf9SOC0ehc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Z3W5Bcdvvzk4f+tE65maViqDaqYrEgaTDDtfcSY+Jw53URy5A6NcG20+SSr4qjUYI
	 VwSyMnfu5/npnTJDJ/spMH5BKC/0c1uEqxwmGmA4TIOWf03RHtvUCzx1Ia0dTvm3u0
	 FTMeGbPMigb4f1C914edIAooxuOzaAk4GTm6HW1nLtA+R+9BBdF23Desjp1cl+yFTH
	 H/z29UBpRjfm2UT7o3xDaFT/6VQtjlj9/1QpKkYcbEFvPQW7C14ctS2pGXD96zvuqZ
	 DU58EK21QJKTk4XXCo6/lIEfYgnTDD6OfZSCh/vljL235tcCEt2yBIcd37EdYimleW
	 +8mG8sVoqEn3g==
Date: Thu, 23 Jul 2026 08:05:28 -1000
Message-ID: <6f1bb6c7c7312c541876d87e44917f5d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>,
 David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>,
 sched-ext@lists.linux.dev
Subject: Re: [PATCH] sched_ext: repair kernel-doc comments
In-Reply-To: <20260723173118.327466-1-rdunlap@infradead.org>
References: <20260723173118.327466-1-rdunlap@infradead.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Thu, Jul 23, 2026 at 10:31:18AM -0700, Randy Dunlap wrote:
> Add missing function parameter descriptions and use the correct
> function name in kernel-doc comments to avoid kernel-doc warnings:

Applied to sched_ext/for-7.3 with Andrea's Reviewed-by added and the
subject capitalized.

Thanks.

--
tejun
