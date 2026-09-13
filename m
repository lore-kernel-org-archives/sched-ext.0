Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C1D36DA15;
	Sun, 13 Sep 2026 15:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789315185; cv=none; b=UIYXB95A+BqAYfhIyG8GoLIfg1C+lcLF+HT4V4esCaOXbRu2E9Db3tw9MUu8izxYtG4w1ZHqqGS/ZfBz7s1hUpFknGTW13QXzGcABPfOpEa/1ZvOlWaqhigU4A9t8PYBlXwpe5bpQ/GOuxrZj/H5lSAoOaSGpY8+CteZDAaKzsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789315185; c=relaxed/simple;
	bh=X5vmnqj3J+VCr8meY4hOwsreJKsImN/OL2V71D8gt3Q=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=X11id9vL322k4p8prnCAzAHQRzuWVL66x0wYxGIF8wiF54v2QqPohqItc/2ebhNbISXXO+6yEldumHPiOfNAXea2xvIuDf27QPFfftRms92Ag5t+EBiVXCuzPV+YwmkM3ieh1wAdS14r24vwkLCvBG44T/wfxnnjj/qi2ZLz9UU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4sHO2xd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4sHO2xd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2F861F000FF;
	Sun, 13 Sep 2026 15:59:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789315184;
	bh=6GfjTwMWK0m8lsyq1cjarbb7FO+Mh+NjaIlzbi9KhiA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=n4sHO2xdU66tAUj1dNfyxTao5anIuyVkti76VH/7/sceN03WtRU1N35V+UD1lOPx9
	 htXD8Kza4SkjyjWGnqvliOHB6qkQSB2znxRN6ehztUDCJHmX7ljuGRXCiawVx1NvBC
	 6TExsqHPM/55XQrv7U8wZk5KbOYJIY9eEtukkK1x4i/OiunkdOIIzXZBr36IfqXElF
	 E2nU7Gu5qVCaxwoQn1SupWI/mlFuML/zEaN2nH5+Yk+Q/cVl9cpN6PwoMxFyVvOyWg
	 uOaC8aPQPDx8t97/wOTQNo0y217C7Vu1IITuOWjx3+jZLQok0gDMiuRBV1Ngb9dPIj
	 SZ4J9QYrKpWnA==
Date: Sun, 13 Sep 2026 05:59:43 -1000
Message-ID: <f5041873e1431184067cc977634e51ab@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Qiurong Fang <fangqiurong@kylinos.cn>
Cc: tj@kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] sched_ext: Close the pre-enable ops error claim window
In-Reply-To: <20260912131518.3428032-1-fangqiurong@kylinos.cn>
References: <20260912131518.3428032-1-fangqiurong@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes with minor wording cleanups.

Thanks.

-- 
tejun
