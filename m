Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C92D91C84AB
	for <sched-ext@lists.linux.dev>; Sat,  4 Jul 2026 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783126477; cv=none; b=YtsgPYqUjCfjvqwuEpT5bg6eYotvcR7Ooc1tVc1Tnc2kNrrdM4p+14glp/JQ1MYcPRr3JTDsQH/Hc8Q3V/HmbLCjKowiB4TqW6wP+Z9+30kJxziH9FX4cWdz2qHgyM0VtSDrSsZ/c130OsvZklSsDhpmHk10wKtfSYNpPe3jPEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783126477; c=relaxed/simple;
	bh=iF28zoQHUfL41+QzakIl68/h6vJzs4DGSaCwA5P7Yaw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=tJj7X7STwUxapRRO/wM79JJod9367h7fd8FHbb/3lYFGyQslb/KBUUEakonQDDhbBK73j58LE9eXYph3YcQk9h5JhsrnVipWxuxX7Wsqcntuj9O5hSgMo+sKStzDFIbh0i2zKOBLH8iljblGAPTtox9uT8Wy4PgnMqL/0TPM/8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MU+JEnlQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MU+JEnlQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848E71F000E9;
	Sat,  4 Jul 2026 00:54:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783126476;
	bh=iF28zoQHUfL41+QzakIl68/h6vJzs4DGSaCwA5P7Yaw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=MU+JEnlQwkW4EOk0RonHfx/SG+ERDVX+wx0rv4UmqRZXZ+4hkwI2LDR965p5bplRj
	 WnFfXu0Uj7EwnEd9CZsDhLcOnJU39x+HynclzZAUOU8hyZSjOXFNeuYga91HKQWm30
	 FzlsawmC5PHOJ5PIhT//DkbcqIowdrb26URxkw9h23dxZ2mwzGgZEXZFHKZtAPLbEE
	 4LR6m+O+sDeXezK78OjKj7zoQ1zIU7y1hmp1YOFsVjYvpQoIZqwZw3vJ+xjH4+AHWI
	 ZE9oJ9e6Wwsd3W7GlMbkb8e5pIATjZl1lkEVfJEwQ0aUjLFEJhsExMgthtVZArtOow
	 LtLnspw8fnehw==
Date: Fri, 03 Jul 2026 14:54:35 -1000
Message-ID: <542001083d535fff8d67fe648a52b598@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: sched-ext@lists.linux.dev
Subject: Re: [PATCH sched_ext/for-7.3 29/32] sched_ext: Replay ecaps notifications suppressed by bypass
In-Reply-To: <20260703142816.30C601F00A3D@smtp.kernel.org>
References: <20260703080159.2314350-1-tj@kernel.org> <20260703080159.2314350-30-tj@kernel.org> <20260703142816.30C601F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> [High] Concurrent CPU hotplug, bypass toggle, or scx_bpf_sub_grant()
> crashes due to a NULL pshard dereference when a cpu-form sub-scheduler
> is linked but not yet rejected.

v2 will move validation (which rejects cpu-form subs) before
scx_link_sched(), so an invalid sub never enters the RCU tree with a
NULL pshard.

Thanks.
