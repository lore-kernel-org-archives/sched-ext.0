Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85EC046B5;
	Thu, 21 May 2026 07:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779348881; cv=none; b=nR/Uu8FNXfaNaD02yUeZT1tUmNtnUkb1stjbSDBrnRBxf29eaL0T37Qla7UflK5D/V/ozGAJoTsMU2tsYogRzqnu9XXrvfeNAL6leJVkry9QSyGTSYcT7EQDQe5022CHowcNYLvz/MhE0c0HGW0ONqAmqYyxWeZg2edFV/Rn9G4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779348881; c=relaxed/simple;
	bh=M7Jb7I+DyzDq0HZaIBUh1RCi7Lg9OghVl8266ehse3I=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=Oep2WHvCLuMXiUc8j55nTIHTHW1z4MtmfhCTsjPyMOtR6b15RQKlqmWVPXXZrOYvc9cQNVX9VX6um55YlwlqHjdmKf6mhZ5OY6BAI9XjpGLDBIos9whTDz9RtATggP9O6vQFXqrOwUBh+f8flbjYTYbFWyLpMG4zp2QSzK1CX0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QsdJL6VA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QsdJL6VA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EDC321F000E9;
	Thu, 21 May 2026 07:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779348880;
	bh=M7Jb7I+DyzDq0HZaIBUh1RCi7Lg9OghVl8266ehse3I=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=QsdJL6VA68LngTXb+sPro1djGXGATUHWhpCMjt/n3dRdL0F9Uach08YpSbWMb8DdZ
	 gi5pOwOSVva/QF+B/N0jgk+TI8fHECkdGJMhk7lzRh5xzdSrFhS/sVbF0756NZUtfG
	 XrJj6QX48Djy/1O6LSamVfPtvmAgTNLvDVafSIOjRJLHw/0lNxJzVJ/rbe5w3CxTS1
	 cggvzDSbBRWp/40ntrEl1+UYT/jYWPHxX/Ktni/fntmbHogDpq3VLs65QPJHDqYTKd
	 6ds+8tiVxaYrJtrXiwGUTllPUdtKqCDNefqKzseaw98BrlifWyMZI2Nfv04wmLuQoH
	 hQY/ozV0KTVuA==
Date: Wed, 20 May 2026 21:34:39 -1000
Message-ID: <8df2d55b41e8d91782a8c7b2d316f8b6@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Andrea Righi <arighi@nvidia.com>
Cc: David Vernet <void@manifault.com>,
	Changwoo Min <changwoo@igalia.com>,
	sched-ext@lists.linux.dev,
	Emil Tsalapatis <emil@etsalapatis.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCHSET v2 sched_ext/for-7.2] sched_ext: cmask improvements
In-Reply-To: <20260519075838.2706712-1-tj@kernel.org>
References: <20260519075838.2706712-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Hello,

Applied 1-3 to sched_ext/for-7.2 with Andrea's Reviewed-by added.

Thanks.

--
tejun
