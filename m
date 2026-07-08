Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4292D4A33F9;
	Wed,  8 Jul 2026 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783535817; cv=none; b=Mi1YEl/weZ16c/CXbv5jNS3/f7N2wmxc+6VqdiAoSV0FsyUol955n8o+Jc3QHXCwBnNiU52FWHQg75sd/cbD0kDwhwRHTR6KhAK1KEzzDvahpmrtJWG4/isJhnW6iXpBBCLNXjOePEQfqrdirtce4m8uduvft/YqIMRSdrTaivY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783535817; c=relaxed/simple;
	bh=XRxHUs685Aez8rZ98WVjHOSTH+VG36Lc6uTVxnQLC7I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=aQJy+/as7w8Bxsk+2U5ujlTs4wjrWxShKVjhqqZlWzTSC0o7r2pGeZyV2nGDmQd5A7891GEwU6lmaaG2RcVQmNHqI7vBXV+NqL5qq2JvF7X8NE6NXaXngyRpbn133DQ+aCXju34kiU5HX5iNfY+Gun8710TFGRvsRENCG6TMuRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LghESwkg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LghESwkg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E23AA1F000E9;
	Wed,  8 Jul 2026 18:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783535816;
	bh=XRxHUs685Aez8rZ98WVjHOSTH+VG36Lc6uTVxnQLC7I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=LghESwkgWf91nMbFQ2807KqgHEiJhBMIlWJHVOdAiE1xwQGP+6nnDJ1Y+neTFFufE
	 pLe6Ma2VzOUVYLiu/I1HnuqUWVACxG5y+75f4qu6KT97IvmxiviYdMUguriNEOXHXI
	 DQjldNiLdh11aI7ly/FZF+ANvoZk5jm+F7zMFAUSDsterwDk5uUVEdg6GWDeLXzsyy
	 0lQnnbNOzmfl2uD5SJ6rrT9NswAE/rJjQAdeZooJ9InIA5q23khfHhvgVtujN4u06U
	 1bbrLqJlNpvSy6biyU1hu9giNWcA6H5MSR7DAjqDbiDHx3TKlLOE/U+269a3u3JXXV
	 3C7v1+mLG7faw==
Date: Wed, 08 Jul 2026 08:36:55 -1000
Message-ID: <3e37aecc051e1e272f4a52ca37f58aa3@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>, Changwoo Min <changwoo@igalia.com>,
	Joel Fernandes <joelagnelf@nvidia.com>, sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org, Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCHSET v3 sched_ext/for-7.2-fixes] sched_ext: Fix finite-slice ticks on nohz_full
In-Reply-To: <20260708074812.1041434-1-arighi@nvidia.com>
References: <20260708074812.1041434-1-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-2 to sched_ext/for-7.2-fixes.

Thanks.

--
tejun
