Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8B0342515;
	Sat, 19 Sep 2026 14:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789827927; cv=none; b=qtYcAdmvzYzTGax1J8GC12gDrglHRfdGli7MGLvU8XvegN1a41SwP5lN4G6uY1V8siCTih81yviHhlb//HBh/wx0xSWx0vV6NNZ0cYlku04IYA2FRjWAzfSbBYnXWjOOj9LSj/ngCqfxgSmse5H41KlM6/gxjCAIdb6sFilr7H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789827927; c=relaxed/simple;
	bh=6bpPVbnCKun8WuOU3fyP/bwp9od0wrS5JFzp7ohu7Yg=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=uT1kWieCg8ghKIPc0CpW+mWyeyIfwRTh3sc4oDohhDYrfmlAWQyVMZE2Cz7ZRkcXUIRk/Zo4U1v7agYwwS5ni60nKKmH33Aybwm/4VBB7J6VWVldKtOGaY+SR6cD3hqbONws7AbPtJeOGc/RcYEc20mePdQ1x5nF42O1+PfjOBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BKBk1wIh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BKBk1wIh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E7AD1F000FF;
	Sat, 19 Sep 2026 14:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789827926;
	bh=KbsYxcwmnAuUk0iHPsVLX+cDJzBgycs4Jf7Suixck8U=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=BKBk1wIhB6WeRIhtwwvKWm0f8LlIpOMlzpA/jUNd5UOvsuW4TflxMMgJevhwat9P6
	 mFwKVscptKoKPwLMFNZGf+oa1B5TURjR4FfGNL7TmHThJv0i8ecmx9UjPsCkT+HvU0
	 B/7jhxjCv7XyrHHevFtHXCSZVdbF0YYXqnCxIEEbx0swLY/Latbro4vbNR76XOPBzw
	 Zznf5StMoL+s5JnR4BLQXSHHDWRqLmgyBc3KfwL0VLyTEOTgXI+Y1qaVjPziPd9Em6
	 1q8UBD9SqT82SF+3hO1ozgw3ykg8pMz0K3F/Qu0i70Cah+BxZyeemeeWslJPjP4w1D
	 SGvkBK+4HjsuQ==
Date: Sat, 19 Sep 2026 04:25:25 -1000
Message-ID: <a15b9c3af22b59ef8080cfa09907aecb@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: Tejun Heo <tj@kernel.org>, Emil Tsalapatis <emil@etsalapatis.com>,
 David Dai <david.dai@linux.dev>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org, sashiko-bot@kernel.org
Subject: Re: [PATCHSET v3 sched_ext/for-7.3-fixes] sched_ext: Pass the initial
 cmask to cid-form ops.enable()
In-Reply-To: <20260919002838.1960071-1-tj@kernel.org>
References: <20260919002838.1960071-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

On Fri, Sep 18, 2026 at 02:28:36PM -1000, Tejun Heo wrote:
> This patchset contains the following 2 patches.
>
>  0001 sched_ext: Pass the initial cmask to cid-form ops.enable()
>  0002 selftests/sched_ext: Check the cmask cid-form ops.enable() receives

Applied 1-2 to sched_ext/for-7.3-fixes, 1 with Andrea's Reviewed-by added and 2
as the v2 posted in reply to it.

Thanks.

--
tejun
