Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61BCA26A0B9;
	Sun,  2 Aug 2026 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785702019; cv=none; b=qC6bH/nprBrWdhsidUrnWakHobBCPSZjtV7p2oZoUXyfOGBAgCuoXi8i7S5C8WKm+NpqfuAaZTut2IWboPiYr4f6ZHJeDGFmVn60i8va+ukBbS8J9jydcKCzH9CALgo2ijibcdfvpnQo4Vu++sflIhA73pnXLeg+zke6m3dLlD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785702019; c=relaxed/simple;
	bh=TQ0DThrh5mT5SBWj87o8boY1SZW7cKOpfsD5Cm6tFZI=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=jGkBus5NZI3mYX6igry3I4fs9Bkqht7CIQYFSxUy4kLpFcD8udvj64evc3pPB1QYGf+iOEzATgSwlqr2UNmS4ow5MgZWgQsDgM0U9ISa2nEWrrFaCSqOdQnW3tlQHK071NAa7zOyBiiByo5YsKjmKn7JWghmRiM8X8O699/nayo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FwjAgPOJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FwjAgPOJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE63C1F000E9;
	Sun,  2 Aug 2026 20:20:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785702018;
	bh=TQ0DThrh5mT5SBWj87o8boY1SZW7cKOpfsD5Cm6tFZI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=FwjAgPOJgDQpjxjakL4E4j21G5JUelrQmspV1hQSHmkPqAVdOXy76ZzHaY+2LpwZS
	 UNjDH2TrQc2wxXa5yFn3qROJ+fWnm/ZGnj3Faufd6V5o+0rdUiAz+57k9/jHgpaBFJ
	 bmaszdOPdpCRNtNXRtpYxWeQ4dYIzIIq+jbzj1c1DBPCdHjoFPzXZjOvGR9ELKfF1M
	 TuiVkz5PLz+8zQULghFcS8nVOdHC6QIPXVFRfuXSEjGEUJoRBJeYRlLjxHVP3GJ+Kp
	 y7BF/FNCbjX88OLBjIBwDBrYodND7APkMngeB+IsqFUOQz1cNN1CPe6Lm14tW0a8ib
	 jtPvG7aS6rCag==
Date: Sun, 02 Aug 2026 10:20:17 -1000
Message-ID: <dc692a6642cff66bc023912fe385d2f0@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Liang Luo <luoliang@kylinos.cn>
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched_ext: Fix stale @cgroup_id in sched_ext_ops
 kernel-doc
In-Reply-To: <20260731023004.1062947-1-luoliang@kylinos.cn>
References: <20260731023004.1062947-1-luoliang@kylinos.cn>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3 with the comment rewrapped to stay under 80
columns.

Thanks.

--
tejun
