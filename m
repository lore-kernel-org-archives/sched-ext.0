Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DAE368D5B;
	Fri, 10 Jul 2026 16:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783701373; cv=none; b=XFtlFoVNwqlvCEYZ5+dOzlzA4wW2qzKW/2nGqw8llhKHRssXdvoT1A0bhg/GYd5mcdEWiiqUcCIxOt1V8py4Z8pCLBJ02Yx+DsZKeiKxVdilGjlr8YzCZhdTpfFmC6+rRewbLjMyB18l0ZLXQmGUNBWe1GXvgdxsQ/FORP5BnRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783701373; c=relaxed/simple;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:Message-ID:From:To:Cc:Subject:In-Reply-To:References; b=kesxK+dZslO+qNDVGlYthLpd9zI4nxkCY2nPZDA1f2C6gd5tI4u3XA9JLFCJDH70mJdw4k/U85Zlr7Y8l+ZJ46GIByMsUaBZ4AEU4xtQQfabHhqnhDyQhmZJlBiAJmvuw22eRRIdNTej6oOm1X6HF90RS5FacbZ1Hv/AM8Yiozo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lsmmtBUS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lsmmtBUS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B921F000E9;
	Fri, 10 Jul 2026 16:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783701372;
	bh=QZy+W4+BNWiqF7AxQn8o27OELqmWr3Sc1evQOKfzb4s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=lsmmtBUSqXlxe4PTn7hdWrbadT8/0pEakKSHENCeT0F/QqvUlppk2tJFFGr8v6H3H
	 tCeROqL/jxiV7kvBwxGP45zLqlWqCyPO4FW82Z+RAhepiOTyN++3vpnqmVGT5rdnCp
	 nTTgRt1BZ9WuML75wPRNeqjIYBnKmlTKNpt4P5CpOYZeML38E7+XG0MfHvW8kRw7Kp
	 +NKtc3Tytatu2tVXDHM86bJIAbRZ7cejdlSyvIDF9nQ3re93CuYMBiM3wzswI8y0Jj
	 6icqouC4UiBUYDXVZglfsijYQYHyhiXp00bH6KNLRN9Ehb7AEXgGMVddUsajxFIO/y
	 iieTJt7Yn8kaw==
Date: Fri, 10 Jul 2026 06:36:11 -1000
Message-ID: <7f2967825be8b3238352cb467eb1a70b@kernel.org>
From: Tejun Heo <tj@kernel.org>
To: Pat Somaru <patso@likewhatevs.io>
Cc: sched-ext@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: Re: [PATCH v3] sched_ext: Add tracepoint for scheduler exit
In-Reply-To: <20260710055911.914465-1-patso@likewhatevs.io>
References: <2d3d31a802b30f340248db4a986cfa4c@kernel.org>
	<20260710055911.914465-1-patso@likewhatevs.io>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>

Applied to sched_ext/for-7.3.

Thanks.
--
tejun
