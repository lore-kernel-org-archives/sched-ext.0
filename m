Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994C44D6C21;
	Mon, 12 Oct 2026 18:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791830420; cv=none; b=b9aGI3kzFON6AngdaK4B2Nq40Stg9GyahsLqcc6cuTljwwAoKprrYh4IORuB6V2a6bORs+w+8UBWHrOxAcQe45oMTUImqxaYGbzvRavLp8Qg/+ERifV0//WdkkaeLZ/avP58N7MiaxdEg1CMQXwJssWElsIoM4jp32HUmVDhpso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791830420; c=relaxed/simple;
	bh=6ZYSnW3OCQg3rKNEdpSgRQqHzhmP+8hMsQLXdt7kGCc=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=c1W+cbYRFN0QplVHu4+WgF6Sw7B8sSVdvVnjy7jVcdjPrrj0xRrr8r9WsVTOMJkg415beaQF1l2CrC2rOhto5ze6RDhpH2Bkad9lLnxO2QQEB8pNUp1NUXvg3g2yjPLdFAEFaoUYiy2FTGrHHtBHplbqYJgBifHJVJQnc31JTl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WlW7Iggr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WlW7Iggr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 281DB1F0089B;
	Mon, 12 Oct 2026 18:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791830419;
	bh=vdYdcLpEe3pESwXAr8zcjxdN7uRnLh5caQ1PSKsOWB8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=WlW7IggrD58bHGXkVQzS2CcFk+nK40fQDI/lXb16lFlR9qxA5YEgKYaDidenfc7pg
	 1HEZyuCSu6ClN1BQgL6pge9cBosVxN9j7Atf6s4DGktscV6SM7leuw9ZG9IQmyIWy/
	 E74XwgrKVQhD9uyl+EjIFqMs4Ri897wI3LAYsBIeS9hrBQdMWzWGHRg0mWPjMw2ju8
	 KGkdT3D3czsSvvhFbFCItHB38g4+VX9CEbBrPkD2BKOZj1VYVR6yrWZGa8IV6kKdVn
	 R+qTKt8Tsi0TUlGE60CfXM8DFMofVHNH9m8/qhPOqg5wJ6suY9Mrig4zikVbl3iZ9Y
	 tnops2bPUGqVA==
Date: Mon, 12 Oct 2026 08:40:18 -1000
Message-ID: <03d78d3346d0a0aacdae06c07550775d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sched-ext@lists.linux.dev
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
	Changwoo Min <changwoo@igalia.com>, Emil Tsalapatis <emil@etsalapatis.com>,
	David Dai <david.dai@linux.dev>, linux-kernel@vger.kernel.org,
	sashiko-bot@kernel.org
Subject: Re: [PATCHSET sched_ext/for-7.3-fixes] sched_ext: Fix bypass
 propagation and the bypass dispatch claim for overlapping bypasses
In-Reply-To: <20261011214028.743546-1-tj@kernel.org>
References: <20261011214028.743546-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

On Sun, Oct 11, 2026 at 11:40:26AM -1000, Tejun Heo wrote:
>  0001 sched_ext: Propagate every bypass depth change to the descendants
>  0002 sched_ext: Fix the bypass dispatch claim for schedulers bypassed by an ancestor

Applied 1-2 to sched_ext/for-7.3-fixes with the following tag added to
both:

  Reviewed-by: Andrea Righi <arighi@nvidia.com>

Thanks.

--
tejun
