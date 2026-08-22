Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878912931FB;
	Sat, 22 Aug 2026 17:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787418412; cv=none; b=RkypugLHzLj37XYfOzQ+MYC2dCAXLcDYmlNfIeQqqmu/MFW7unC5+6BMfVgoPHEhLewJwIxjRSgCyIfFidFnSP7zTMXW7Ix9MLcxWnDATzZ0XGb+kGleWbxUr1o+/36pQQD05FpG5z5ljFDIqqj5guN/oPO6D/Cb3EFIXmu58MM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787418412; c=relaxed/simple;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=B764Arj7PYHxegO/v4VisjYanjJytfElT7DwOiApc1GEVivUM1OlzpqE29x3CVYTsR9AUjwkjkmURJfr2YgDq/+XuZNgMyVslXQaRBwMzOof1aEZkdDvFIl3m1bK3EV5sRPfv2ONpTztrrPE7DDi3ksmc0AbtJeJjy1EQ8tzg2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbzM3+a2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbzM3+a2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D29EF1F000E9;
	Sat, 22 Aug 2026 17:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787418411;
	bh=6Y7vYf/xc/TsRZfeinhAcNhu9VUF65Y4YoGWlsYueBI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cbzM3+a2LJGodJA6loGMY0f1J0Nh7GQvEQiVroNc3F77Wq+dNqRu22B4PD5KG+iED
	 7hoGVkOBUJfDDIVtDAc0jOXqJkjdtVZP3QZu71f4VB6KG5kj2+IxdMNSKC4KJCQQvN
	 pwIYLRTWGELd0+q12W1uFewRHFuwcJO2CiFlLtVchdZAAnJWo/qGfAfUVq3dVnjCVk
	 ZpUl7UJYL9+mRGoYZFQEvtpHin0Dj8tEDdE2MPazYtw9uzGo7lcPXWd9W4ceSLS4hA
	 NLGUOsS1o9tRHQsxMNYDP7vAzr6QrzJWrfiYib+Yn59H7F2fuVW0hCWi8DIrcK7Oaq
	 TPvdDcBWMMhUw==
Date: Sat, 22 Aug 2026 07:06:50 -1000
Message-ID: <a476c94339bc18cfccf31b3726246693@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Fix spurious aborts in scx_bpf_dsq_move() on ownership change races
In-Reply-To: <7b3b7e35d462fe061105f09de3a2eba9@kernel.org>
References: <7b3b7e35d462fe061105f09de3a2eba9@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes.

Thanks.

--
tejun
