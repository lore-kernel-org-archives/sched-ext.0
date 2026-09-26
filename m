Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 168283A5E93;
	Sat, 26 Sep 2026 20:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790453732; cv=none; b=m7xLYcwE5eYHRZp+Lu1Xxb7MXoNDjb5N5SQNbSAhVeohlSZ24/UtCekPsvkXl9oEHjYnjhAjOct1bM1VPfa9aJZAXio4uFPVnVWuBe8mLNUZ3dGtPjnkdS33GciBmwpjfjVCvo4usRPPOq7H5f0CyvlpCkS3p/pDZQcv+uaUT/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790453732; c=relaxed/simple;
	bh=Y5Y65wRjnz9b4ZT3y9T9dK5wWRRWBSVXSucPiNrHwn4=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=OGe9UQZ0h3ZSfJn5BP7UqgZ6Hijhftxgbv0ZwZUdEK3NWGmN+AwaneCw5BJaNvJ2K4TXu3Y25lFtd7xclLT4BxXDLCS8Jm69rm6oCi14iS3yC/mHFCSX/sDE6k6BlPYGNCM8Z97JO4HMxJVgF1aZC0cmRs0+XRMOU4Gfh/e0C9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Spp11HZg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Spp11HZg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D77791F000FF;
	Sat, 26 Sep 2026 20:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790453716;
	bh=NlXNCgfjp00Wqm33N2mGBM2JARc89OfWL98Zhs/TWsI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=Spp11HZg1OELZfHQyk0PDfwBqfI142x3wrG12xAGGftREG0E5+wkqjtwGrVKn0sx9
	 KLeLirNRQsYN8DyBiRJ6jENJQqelg6cArgQUD2dKvOsnxyokwmBSsHVx8+SOk7OrQ6
	 SIFzEoGLnWBkYgehEjxeQuEZNvmqSIBqWFvO8Jp2f2dXxoEJJVgCRTatvZsStuQrvK
	 Mh+A6dQhaBrY77jYsPMYU6NupeDXGzc9vo8n8PqIoLaCkmuFIXXdjQzmdCfTCVoVyD
	 xohUWP1ZX8x3Y0kYmatII3rHiR3Fyq8T2soIO48T8UAqvHmMp8a/sN2drf2I2EhJoB
	 5rALqjmj0B0HQ==
Date: Sat, 26 Sep 2026 10:15:15 -1000
Message-ID: <91086617198af8f4ca532252cc80b8cd@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>, David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>
Cc: Emil Tsalapatis <emil@etsalapatis.com>, David Dai <david.dai@linux.dev>,
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes] sched_ext: Add a size argument to
 scx_bpf_cid_topo() so struct scx_cid_topo can grow
In-Reply-To: <fa6479d36b528573565ca22914451317@kernel.org>
References: <fa6479d36b528573565ca22914451317@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3-fixes with the following tag added:

 Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

-- 
tejun
