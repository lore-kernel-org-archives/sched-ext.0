Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D159442B15;
	Sat,  5 Sep 2026 16:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788626435; cv=none; b=OFIb8VSM6OwJvaCKFqAGwvmoPxrL/R3RcEZ/utP2jqojeOql+xbZfUl3SWrEDJcnH5QiSFdPSp/3AzyAmT0yBchISTXrtujdQQJa90Des0qffw8ScPbeEIqGhhqcIwEr3isaawW2rJszk6zYsiVTxEptzt3Gc7dKqmeAvz+8JZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788626435; c=relaxed/simple;
	bh=CnwYi+nWqq2lvtOdZx1n/m/eJZCP60TIKIMo3jjO8DY=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=idklj8vqioC+CNfLUxGOlfP35eJl3F70cMxqeisouZivN0grPtCMCMj5cRKrrVpWcjxU5Q7/lewnFp0/XtmZhGEK9nZIU5usmrisiSCdgIo3rzninQC2pEPCUb6IY0TNY0RyDZjC3k4NnOIJe2MqCGwwawysE9tJ/xvxjjzBkTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G/woxpMD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G/woxpMD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91B8A1F00A3A;
	Sat,  5 Sep 2026 16:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788626433;
	bh=CnwYi+nWqq2lvtOdZx1n/m/eJZCP60TIKIMo3jjO8DY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=G/woxpMDhW24+seo+Mq4nGSI9FQfkD1IZEXjS8oN53LwnRUmSoXeb77J8YmnlAZXg
	 GQoxUecZKWjrwy2tEFuPgvZmmC+eQvQkCVB0UKa49vGxEHgpM/8j8zK2ZrJlIQvlan
	 m/cHbJ4I2rRRIYRl6wFcE/zspJOXaciH1yBPQFLvbfHdnZ/5tuCDmIg+iPg9kwAXTJ
	 D4TckdrXeXpKT0B8ON9chjq2212E2BbgoXC+4W9XD8Nz9X7/ZjWsgRRQclwbkdNptD
	 uIZwusOy1mThcIp2/9XcQ0SUsQ5uLS5Y4HN59VFgj/GOi9YgoAkxe4i1W2r8pAa2+W
	 eEv/cUC3+MqZg==
Date: Sat, 05 Sep 2026 06:40:32 -1000
Message-ID: <c1b5b24af15ee3e117bfa07f8c89aad2@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: sashiko-bot@kernel.org
Cc: David Vernet <void@manifault.com>, Andrea Righi <arighi@nvidia.com>,
 Changwoo Min <changwoo@igalia.com>, sched-ext@lists.linux.dev,
 Emil Tsalapatis <emil@etsalapatis.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH sched_ext/for-7.3-fixes 4/4] sched_ext: scx_qmap: Place
 only on cids whose caps are in effect
In-Reply-To: <20260905162223.6EF521F00A3A@smtp.kernel.org>
References: <20260905160958.1565156-1-tj@kernel.org>
 <20260905160958.1565156-5-tj@kernel.org>
 <20260905162223.6EF521F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

> This is a pre-existing issue, but can lockless readers observe a transiently
> zeroed qa.self_cids.mask here and incorrectly fall through to the rescue block?

Yes, but scx_qmap is an example scheduler and the result is a spurious rescue
insert, which isn't critical. The race is acceptable.

Thanks.

--
tejun
