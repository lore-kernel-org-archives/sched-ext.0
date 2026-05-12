Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EBF34B410;
	Tue, 12 May 2026 18:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609296; cv=none; b=it1KPBznII1va9yvi5nDO5GhYc3y609C6BrOjK38xKqoCT+af5DNFfb8ZdRV4dZiSRypD6/rR9kkGwTg/CCpNet1na9YnukTUVj38fhYz2ko9dUzdbdoBUHxfbOmfqu2qBm86T2zp5c1cjBo0ZMF9bp23MQ3ODOyrK1q1iAXiaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609296; c=relaxed/simple;
	bh=q4Iudcp8Sc7Dh31bCkOU5aqihylRVTb1oL/cfF0yj6w=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=hniyEdjcz+amGv5LJHN0pFQcDaRrkNr9TaIsSyKrVXwgOzZuKRgRsvCor62eb1uLhw92TEz9njDrWthTph3WVKU7glBKLowYdJLS4wy8KMzihIuF4Mbg3Mpe742847UANPGNYfUfB9qSXfP6A759V4FDO67BgC5eDrCWuhsF/YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fphacyr9; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fphacyr9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FEF6C2BCB0;
	Tue, 12 May 2026 18:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778609296;
	bh=q4Iudcp8Sc7Dh31bCkOU5aqihylRVTb1oL/cfF0yj6w=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=Fphacyr9C4QthQyOcrIbQbTKcRz1JIHF0c4GjlsJ8mO7KsX2M0r8SRR+RzI0jdLaQ
	 o5T7I4+T+qCyjHQgxHnxQnXTA+SLqrkfn1kwe2un4UJSHXnzJx9pZ9S/1tfIOA+rAX
	 rdlxhysYSoEqk5Gk9XkmS2DTpnMeym5hgl1vuKFIN2sQFFw4180/aWqUKSOcl41ijT
	 rSQxbC9fKpYYRKlHjGz24TcwD30XZwFs+BTtODHYrn7FYZy0aWsb6Ej+Jj7uz2VMJx
	 U6i5M0A9X4yYiN7VzBDJQtmHbi0X7NH8AkhpZ0+Yy42ftT8KPtm/3BIYZS2/B2sfUM
	 wPemMbMyjF5ow==
Date: Tue, 12 May 2026 08:08:15 -1000
Message-ID: <5b8afac4acacf30b57d81813334b8c2d@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pat Somaru <patso@likewhatevs.io>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH] sched_ext: Add tracepoint for scheduler exit
In-Reply-To: <20260512055632.1096713-1-patso@likewhatevs.io>
References: <20260512055632.1096713-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

The TP should carry sch. With only kind, an observer can't tell which
scheduler in a hierarchy just exited.

Thanks.

--
tejun
