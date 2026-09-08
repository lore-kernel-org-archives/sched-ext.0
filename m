Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240A85921E0;
	Tue,  8 Sep 2026 18:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788890723; cv=none; b=sP+DTS8yvl0mHGBCmcIGYKy/iNHxjPcCrVgnmsCvXAnXJ10TfjlBEArvwPMk7ibObXAU6WM5AUN4QGuCcjZYsCbWRNcprlNqTRvR7FsYzE+3oMhQZ6SRdZ7qceetgyuJx4fnfu0yzy58+V8Am8smU8svSKyXCRI/XHzVL/ltCiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788890723; c=relaxed/simple;
	bh=+izvuhEto/rqxeDKdYSqynpvH9Sk7+k/IJJ1b6pN4dc=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=rlFeyICQsUzqlRO9TbgoE47brEwkyJMBBwiJibMqrfdHQZdqZK8GBNIaUd8kKaq6wmBhUrG2H5UhQQ3IUQzcLeY+9g7gwCmJSoaoG7Z2DzAZ/2qS9tdPzIyOiH4gbjuWZmGFjppP9Kd9/lRYbayhmqstfn80UaQUS2XIydIvmYA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kWh0L6ub; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kWh0L6ub"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 22A8E1F00A3A;
	Tue,  8 Sep 2026 18:05:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788890720;
	bh=yrCpXGcoydJmpbJVtpIANkua0JB5sKTWmN4rMBY1Ylk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kWh0L6ubPYv/MDYuRQxR5esJaWcmU58Vsq1bcH5Ka9bzOQIuDjjkoxw39asU1vaTZ
	 zE32Ay64ZmP8Kj28fvOV/WXB37zaK9q8n9QYhcgR5I1ZpWhuVkYtP3ylPjhiKMfbcW
	 c70c2eIAhRK4b6r9sKUo0LTQ0a2UiowQ2AD7uQ83MhLgF++JGRvnCuGyNJ2bdbvZ/c
	 qO05FIsHl113UKkKRoAELVm0A7AFBocYFE5nSzrrpxM0DGV09haUKT7VHdB7jezI+o
	 spbIFw+eiCS5DGcHTdUEbxeMl6RbQdQu0+KGeWTjoMv2hVK6x0gxV0Nzzv81TMVWg3
	 aeqcJD6G/EiYg==
Message-ID: <87d38cf2983a82fc89e18112510f5091@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Tianyi Chen <hi@tychen.cc>
Cc: tj@kernel.org, David Vernet <void@manifault.com>,
 Andrea Righi <arighi@nvidia.com>, Changwoo Min <changwoo@igalia.com>,
 Shuah Khan <shuah@kernel.org>, sched-ext@lists.linux.dev,
 linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
 Emil Tsalapatis <emil@etsalapatis.com>
Subject:
 Re: [PATCH] selftests/sched_ext: Cover duplicate DSQ creation and ID reuse
Date: Tue, 08 Sep 2026 08:01:34 -1000
In-Reply-To: <20260906144044.849222-1-hi@tychen.cc>
References: <20260906144044.849222-1-hi@tychen.cc>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0

Hello, Tianyi.

Applied to sched_ext/for-7.4.

Thanks.
-- 
tejun
