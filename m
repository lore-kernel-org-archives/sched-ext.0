Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAD141925BC;
	Mon,  9 Mar 2026 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773073247; cv=none; b=Q+NKAwGStkwh0sPd2R8GuxFefT7A94n9KZnS5oAKEWSp0IurRip20iWB63uIoS6PpIyWhjz+OS7CNdjzthR+rS6HEipg8CCZZeUty56E+ToECnJHnsCyG+F12eL0D008vWj9wymDgzFd+7964FPDiqPyE5Ox7hk4NXWFHTsnsz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773073247; c=relaxed/simple;
	bh=WQ+YD74YtokUk1e2In7267OcxagMeuJAbZE8t1tGkBE=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=m0o+Ronrednem+C/lDt2eO5pg5IpuWdVDH7XTFkpUawrkHNgMPJDPeHfs0zISa4/HXj7BwGwrNsZaWv4ZqiQEc1yq4re66KbzemyXGg+b29E8KmyFvcpOe7oxDPwG98wQAcx3zTKXYOsO/oqQ9Ad9rjGd5u8SehY3KQSq53jFyA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bynWYPl8; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bynWYPl8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAB29C4CEF7;
	Mon,  9 Mar 2026 16:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773073246;
	bh=WQ+YD74YtokUk1e2In7267OcxagMeuJAbZE8t1tGkBE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=bynWYPl8LKFylaCzA1qkoEYIUDw8sd4in8iWRiOYQq8Qmi4Yx4OeAM6rTHe0K8W9D
	 A+css8MEwpEpOGYOAO2EjiG8N/wqtBFBXlXDiX80Vln7Qu/bHlraB78ptap83nP6dC
	 OBcw5Ljx6QXr4Zyr2UrChZf0AjkdTs14D2qANjZ3RxaLh7ZRv34Wufwa2dhmDYyO8x
	 ppMMg9yxT19cwIPDAiK5HnBUw4hO/ao+QPHxJFhPNGM9O5iUHwTGiFNLcz8acP7Se0
	 atjLxEw4nW94nIjehx9TkokcSuQwNo5gMNEC08H+XErgp7VWGK9olg4hWRMPJK0LZp
	 f3KSTQBlOmr9g==
Date: Mon, 09 Mar 2026 06:20:45 -1000
Message-ID: <72d2afeeec8ad2ad87713e9331bd536f@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: zhidao su <suzhidao@xiaomi.com>
Cc: sched-ext@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 void@manifault.com,
 arighi@nvidia.com,
 changwoo@igalia.com,
 peterz@infradead.org,
 mingo@redhat.com
Subject: Re: [PATCH v3] sched_ext: Use WRITE_ONCE() for the write side of
 scx_enable helper pointer
In-Reply-To: <20260309024612.530874-1-suzhidao@xiaomi.com>
References: <20260309024612.530874-1-suzhidao@xiaomi.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

> sched_ext: Use WRITE_ONCE() for the write side of scx_enable helper pointer

Applied to sched_ext/for-7.0-fixes.

Thanks.

--
tejun
