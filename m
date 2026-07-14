Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B6A3FD126;
	Tue, 14 Jul 2026 08:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784017635; cv=none; b=HsBxdkd+/5Qm2pR95PyHqnHu84A0X35SWWoZrzLWHj8qtZbuKfoN8b69nX3Tl7JHzH/Lg3JZAcU75GfUYXKM7w4yWDqCE96oW1xYGI/qo5Mf601Hms7vQ3+zDgqcXMYggiTet5xgatZMEB8UEf5zWMAgy3Hrx5pnFyaHXBwifOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784017635; c=relaxed/simple;
	bh=L4g+2WjOpLWHgskowopOGszu+j3dathhRUcDWKIH8Uw=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=TaiFttsmf9TBz2a0XG8WNLZHOwmTr/kfcRnQQZn4fYfplPcCafs+WpEaehuS44sv1sxqHitIEe1fk3HCaqsPRt2uzVQ/dbL+ESxARyq+2yKrAOBMB9J6rNqXwBD6glg5AkfH1DWaQf8iAVHf5hD4UNxu776Du5YRQHe48loMXZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RP+ygkaM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RP+ygkaM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D8AD1F000E9;
	Tue, 14 Jul 2026 08:27:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784017628;
	bh=L4g+2WjOpLWHgskowopOGszu+j3dathhRUcDWKIH8Uw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=RP+ygkaM1UBRSrHHOaFIS20i82qqtbbnhpt7Goriuxb7K9XWvArdvsw+R9plojUns
	 UiyuDdB0rZTNN591C75Ws7KAh4Cfw+nzssrSp3TXx5Ezu5NKY9dHePFw1iaAXGbq+O
	 71nk3vL37iZawugBHyI982BjwJIUF0QzmHeJ3zJrD1cF2f7EYMrPYDpPt84aXo/ZZK
	 sZ0lL5fKSk02aylRsi0O/dX23QU1soZdDHuMS5Dg34XxbBTRZssibSSY6GfpLx6JO0
	 L9r7tFRRWQy/3bwxt85M1m2/ohO1mSCl1uXxPSDJuW0cTqzKJBXHpSZ1+Faf77UE+W
	 SjBe6YbVm9CZA==
Date: Mon, 13 Jul 2026 22:27:07 -1000
Message-ID: <5eef63758789c73372305fa117e9ba5d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>
Cc: sched-ext@lists.linux.dev, Emil Tsalapatis <emil@etsalapatis.com>,
 linux-kernel@vger.kernel.org, tj@kernel.org
Subject: Re: [PATCHSET v5 sched_ext/for-7.3] sched_ext: Capability-based CPU delegation for sub-schedulers
In-Reply-To: <20260709225041.1695495-1-tj@kernel.org>
References: <20260709225041.1695495-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied 1-33 to sched_ext/for-7.3 with Andrea's Reviewed-by added.

Thanks.

--
tejun
