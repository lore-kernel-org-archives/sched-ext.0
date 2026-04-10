Received: from m16.mail.126.com (m16.mail.126.com [117.135.210.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3799478F4F
	for <sched-ext@lists.linux.dev>; Fri, 10 Apr 2026 23:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775863086; cv=none; b=Yfg0Wp8gmIUs75NcKvAECDrBkpdFRBNYyckpdyWI6nb+oCkcIEIphBnDpX1mIF7pO8qNPawmaS76RfDsXOprk3m7t42dPeC9vksYQj5avDXhbS9uDcjWKmjekSzIBR7ALq/ChyoV19WjF+j2DYzzBpUPxgz9iP+o7PrH5xKN8Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775863086; c=relaxed/simple;
	bh=JazobPq6BhvzP5Tie4CxqADLvT/x0USe2wG5oOAGZ80=;
	h=Date:From:To:CC:Subject:In-Reply-To:Message-ID:MIME-Version:
	 Content-Type; b=dX7zqHiOTzdiYQGXXKeJuNehiBuGjju9e60+8CgO3+RGKw91Hpz2ua0yjPIkB8mAuEapr91rrsfIraoUqEL6O2PIvxx8giYIVc/uslxPmnV4OcPeky+n16GZ2UzM0qzDtbGhR2KqAAlpo89ChKZf9+X7H12Sqz2SNvNL9VK+Df8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com; spf=pass smtp.mailfrom=126.com; dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b=Sr15+k25; arc=none smtp.client-ip=117.135.210.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=126.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=126.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=126.com header.i=@126.com header.b="Sr15+k25"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
	s=s110527; h=Date:From:To:Subject:Message-ID:MIME-Version:
	Content-Type; bh=JazobPq6BhvzP5Tie4CxqADLvT/x0USe2wG5oOAGZ80=;
	b=Sr15+k258dOOEIW79ORTTwyZbH7y6HAM5QV5kSd18BpE1mocUa7S0iUcFoD82Y
	SR44iAoNl4kvndrG6jks6V3OpB5NnTakK1sRMyn7d0daSgtKBbtNssTGLn9UgIFY
	YYd8zJ446GeqrogRrw8BeydLuw7n9newrxDf84VmUndwQ=
Received: from ehlo.thunderbird.net (unknown [])
	by gzsmtp5 (Coremail) with SMTP id QCkvCgD3_3EIhdlpCwIJCw--.28624S2;
	Sat, 11 Apr 2026 07:17:29 +0800 (CST)
Date: Sat, 11 Apr 2026 07:17:28 +0800
From: Zhao mengmeng <zhaomzhao@126.com>
To: tj@kernel.org
CC: arighi@nvidia.com, changwoo@igalia.com, emil@etsalapatis.com,
 linux-kernel@vger.kernel.org, sched-ext@lists.linux.dev, void@manifault.com,
 zhaomengmeng@kylinos.cn
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_sched=5Fext/fo?=
 =?US-ASCII?Q?r-7=2E1=5D_sched=5Fext=3A_Drop_s?=
 =?US-ASCII?Q?purious_warning_on_kick_during_scheduler_disable?=
User-Agent: Thunderbird for Android
In-Reply-To: <20260410202054.4189994-1-tj@kernel.org>
Message-ID: <8A8D3A99-FDE5-4DEA-B619-756F51146FDD@126.com>
Precedence: bulk
X-Mailing-List: sched-ext@lists.linux.dev
List-Id: <sched-ext.lists.linux.dev>
List-Subscribe: <mailto:sched-ext+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:sched-ext+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CM-TRANSID:QCkvCgD3_3EIhdlpCwIJCw--.28624S2
X-Coremail-Antispam: 1Uf129KBjDUn29KB7ZKAUJUUUUU529EdanIXcx71UUUUU7v73
	VFW2AGmfu7bjvjm3AaLaJ3UbIYCTnIWIevJa73UjIFyTuYvjxU1CJmDUUUU
X-CM-SenderInfo: 52kd0zp2kd0qqrswhudrp/xtbBqgk0q2nZhQlwvQAA3N

LGTM=2E
Reviewed-by: Zhao Mengmeng <zhaomengmeng@kylinos=2Ecn>

