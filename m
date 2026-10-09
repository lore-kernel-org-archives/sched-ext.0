Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 118043ED13F;
	Fri,  9 Oct 2026 21:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791582255; cv=none; b=FIKaUOcRNLy4ZkT/ahzUiVtc6N0PgVK+S4CtzVAcGA8gjWFGlGOu4hIgrJr1yJ/7KNbB4DzI5qT5ZFYcybUzn2Kg8Q+UN3te10D0o0ZAInxoVSI7RPhKT6g1UJx67f8wcgPYYEYYP7GPbjKbpGTyxdIPyLAVxE67KEK9f3JWX3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791582255; c=relaxed/simple;
	bh=PWnQyXHJ/zJ6D5nixb0+iy8kAkrdo1STNYQ+NrxL41M=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aUvYGi7YS4fF8NVtS8l/MpYReAWxGUe2ZDw3x6sUTCq8Gh0+QjF3O/BM1sc9u68m673DKYVs97bX5ND0V7Cxkds/uUyUBQOj8AgjPlVXrOKz7aGnrJcAyNy9SFDPPQysbYcu+ZZButz3YY0E6JP0/RfO50KhcQJEf0WrDl4c9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GA/4vMBs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GA/4vMBs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567581F000FF;
	Fri,  9 Oct 2026 21:44:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791582254;
	bh=N4uV7RiLgkt0pYGxzp3xZ63OktdeqC+slSI4JhxZKkQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=GA/4vMBsE7Dydg4ne83nkeV9bC5ieL4R4Dq2ZZbpoAp0s/fwrvE8jTLVaDNQY7+Dl
	 M0Ra4dFqKOl/NbsUhYUutNKRvAan9hICfWh54gL8jbD4kap7fGYyJ28/BeBhXtDYqt
	 tWJonfuXHwJuntP7s2mC3zFEc4aC7GdvXtSzTH5lIGn4aZT1wqfhdRiKo2vHevUuv5
	 /Dgmx/lX9Y8SjaDdg+R+j6prj2l7NtfXTZvUrCOR+pcGGIpJceDkIVWP82LAIwuT1r
	 gzHhA3wGcYoZnQpDPNDcGDU0fvvHAgOIqkWg4Cho2rBMea3PbUox+uzxKNFydJZ5IE
	 YoWOShNO/vyNQ==
Date: Fri, 09 Oct 2026 11:44:13 -1000
Message-ID: <2b60fc415bbe7299f8637fb19724d769@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.4] sched_ext: Add
 ops.sub_child_ecaps_updated()
In-Reply-To: <20261008093228.2015427-1-tj@kernel.org>
References: <20261008093228.2015427-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Wed, Oct 07, 2026 at 11:32:26PM -1000, Tejun Heo wrote:
>  0001 sched_ext: Add ops.sub_child_ecaps_updated() to report a child's effective cap changes
>  0002 sched_ext: scx_qmap: Reset a child's cpuperf targets once its PERF revoke takes effect

Applied 1-2 to sched_ext/for-7.4, 2 from its v3, with the following tag
added to both:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

-- 
tejun
